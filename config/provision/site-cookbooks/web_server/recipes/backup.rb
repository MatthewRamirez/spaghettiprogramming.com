template "/etc/cron.d/spaghettiprogramming" do
  source "backup.crontab.erb"
  mode "0644"
  group "root"
  owner "root"
end

directory "/var/backups/application" do
  mode "0755"
  group "root"
  owner "root"
end

directory "/var/backups/application/database" do
  mode "0755"
  group "postgres"
  owner "postgres"
end

directory "/var/backups/application/files" do
  mode "0755"
  group "root"
  owner "root"
end
