# Default recipe for web server

%w(git-core curl build-essential python-software-properties zlibc zlib1g-dev libreadline-dev libssl-dev libcurl4-openssl-dev emacs libxml2 libxml2-dev libxslt1.1 libxslt1-dev libyaml-dev libzmq1 libzmq-dev).each do |name|
  package name do
    action :install
  end
end
app_user = 'deploy'
users = %w{ app_user }
users.each do |user_id|

  home_dir = "/home/#{user_id}"

  group user_id # create group if it does not exist

  user user_id do
    shell '/bin/bash'
    group user_id
    supports :manage_home => true
    home home_dir
  end

  directory home_dir do
    owner user_id
    group user_id
    mode '0700'
  end

  directory home_dir+'/.ssh' do
    owner user_id
    group user_id
    mode '0700'
  end

  directory home_dir+'/.bundle' do
    owner user_id
    group user_id
    mode '0700'
  end

  template "#{home_dir}/.ssh/authorized_keys" do
    source "authorized_keys.erb"
    owner user_id
    group user_id
    mode '0600'
    variables :keys => [
      "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAsMWzguQmDktGgheWQ7LYfAx+yUkZD1XgTqXPR/y0ypLIAlggRY4hl1Xd5z89mnt27xNRTXEk1cQ3WzQ46zsKtpdpDpcm1D14eggfTug/rlUM56TeQc4R6Hait3mP4fmQZ+VhNKrAmZGyuul7sKHXeZtvLumRjeyf/EY1O7b8LIrUl9IUHn3qU1NG6UHJshsISApjwm/dlBbXLDJn57nTr1EBM1tAvGWK+G1Nzhbk9v+WWjZoGgFVwCS06FuW7uz/AJ+KAkhbtSQVJomYfbxK+nVonNk4oR0EeCjqE9ygOTh6qtLBIZ1nU6yAEJGnAh5xdsZxpi6UaOnwrRYj0j5vbQ== matt@workstation"
    ]
  end

  file "#{home_dir}/.bundle/config" do
    owner user_id
    group user_id
    mode '0700'
    content <<-EOF
      BUNDLE_BIN: bin
      BUNDLE_SHEBANG: chruby-exec
      BUNDLE_DISABLE_SHARED_GEMS: '1'
      BUNDLE_PATH: vendor
    EOF
  end

end

logrotate_app "spaghettiprogramming" do
  path [ "/var/www/spaghettiprogramming/shared/log/production.log" ]
  frequency "daily"
  rotate 5
  options ["missingok", "compress", "delaycompress", "notifempty", "dateext", "copytruncate"]
end

iptables_ng_rule '01-loopback-v4' do
  rule ['-i lo -j ACCEPT', '-i lo -d 127.0.0.0/8 -j REJECT']
  ip_version 4
  action :create_if_missing
end

iptables_ng_rule '02-loopback-v6' do
  rule ['-i lo -j ACCEPT', '-i lo -d ::1 -j REJECT']
  ip_version 6
  action :create_if_missing
end

iptables_ng_rule '03-inbound' do
  rule '-m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT'
  action :create_if_missing
  ip_version 4
end

iptables_ng_rule '04-http' do
  rule '-p tcp --dport 80 -j ACCEPT'
  action :create_if_missing
  ip_version 4
end

iptables_ng_rule '05-https' do
  rule '-p tcp --dport 443 -j ACCEPT'
  action :create_if_missing
  ip_version 4
end

iptables_ng_rule '06-ssh' do
  rule '-p tcp -m state --state NEW --dport 22 -j ACCEPT'
  action :create_if_missing
  ip_version 4
end

iptables_ng_rule '07-ping-v4' do
  rule '-p icmp -m icmp --icmp-type 8 -j ACCEPT'
  ip_version 4
  action :create_if_missing
end

iptables_ng_rule '08-log' do
  rule '-m limit --limit 5/min -j LOG --log-prefix "iptables denied: " --log-level 7'
  action :create_if_missing
  ip_version 4
end

iptables_ng_rule '09-input-block' do
  rule '-j DROP'
  action :create_if_missing
  ip_version 4
end

iptables_ng_rule '10-input-ip6' do
  rule '-j DROP'
  action :create_if_missing
  ip_version 6
end

iptables_ng_rule '11-forward-ip6' do
  chain 'FORWARD'
  rule '-j DROP'
  action :create_if_missing
  ip_version 6
end

iptables_ng_rule '12-output' do
  chain 'OUTPUT'
  rule '-j ACCEPT'
  action :create_if_missing
  ip_version 4
end

iptables_ng_rule '13-output-ip6' do
  chain 'OUTPUT'
  rule '-j DROP'
  action :create_if_missing
  ip_version 6
end

app_root = '/var/www/spaghettiprogramming'
app_name = 'spaghettiprogramming'

directory app_root do
  owner app_user
  group app_user
  recursive true
  mode '0755'
end

directory "#{app_root}/shared" do
  owner app_user
  group app_user
  mode '0755'
end

%w( config log tmp sockets pids ).each do |dir|
  directory "#{app_root}/shared/#{dir}" do
    owner app_user
    group app_user
    mode '0755'
  end
end

database_name = node['web_server']['database']['name']
database_user = node['web_server']['database']['user']
database_password = Chef::EncryptedDataBagItem.load("web_server", "database")['password']
template "#{app_root}/shared/config/database.yml" do
  mode '0640'
  owner app_user
  group app_user
  source "database.yml.erb"
  variables({
    database: database_name,
    username: database_user,
    password: database_password
  })
end

secret_key = Chef::EncryptedDataBagItem.load("web_server", "secrets")['secret_key']
template "#{app_root}/shared/config/secrets.yml" do
  mode '0640'
  owner app_user
  group app_user
  source "secrets.yml.erb"
  variables({
    secret_key: secret_key
  })
end

paperclip_secret = Chef::EncryptedDataBagItem.load("web_server", "application_config")['paperclip_secret']
template "#{app_root}/shared/config/application_config.yml" do
  mode '0640'
  owner app_user
  group app_user
  source "application_config.yml.erb"
  variables({
    paperclip_secret: paperclip_secret
  })
end

#apt_repository 'nginx-ppa' do
#  uri 'http://ppa.launchpad.net/nginx/stable/ubuntu'
#  distribution node['lsb']['codename']
#  components ['main']
#  keyserver "keyserver.ubuntu.com"
#  key 'C300EE8C'
#end
#
#include_recipe 'nginx'
#
#nginx_config_path = "/etc/nginx/sites-available/#{v[:name]}"

