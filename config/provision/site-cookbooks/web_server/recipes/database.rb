# Our database-specific recipe. #

user_id = 'postgres'
database_name = node['web_server']['database']['name']
database_user = node['web_server']['database']['user']
database_version = node['web_server']['database']['version']
database_password = Chef::EncryptedDataBagItem.load("web_server", "database")['password']

include_recipe 'postgresql_lwrp::default'

postgresql_user database_user do
  in_cluster 'main'
  in_version database_version
  unencrypted_password database_password
end

postgresql_database 'openvpn_production' do
  in_cluster 'main'
  in_version database_version
  name database_name
  owner database_user
end

directory '/var/backups/postgresql' do
  owner user_id
  group user_id
  mode '0700'
end

cron "backup" do
  action :create
  user "postgres"
  # mailto

  shell "/bin/bash"
  path "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

  minute "0"
  hour "1"

  command "pg_dump -ROx #{database_name} | gzip -c > /var/backups/postgresql/#{database_name}-`date +\%d`.sql.gz"
end
