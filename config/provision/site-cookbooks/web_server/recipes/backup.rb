template "/etc/cron.d/spaghettiprogramming" do
  source "backup.crontab.erb"
  mode "0644"
  group "root"
  owner "root"
end

directory "/var/backups/spaghettiprogramming" do
  mode "0755"
  group "root"
  owner "root"
end

directory "/var/backups/spaghettiprogramming/database" do
  mode "0755"
  group "postgres"
  owner "postgres"
end

directory "/var/backups/spaghettiprogramming/files" do
  mode "0755"
  group "root"
  owner "root"
end
