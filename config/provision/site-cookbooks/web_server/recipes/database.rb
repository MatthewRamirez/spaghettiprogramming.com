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

postgresql_database 'spaghettiprogramming_production' do
  in_cluster 'main'
  in_version database_version
  name database_name
  owner database_user
end
