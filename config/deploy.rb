require "bundler/capistrano"
# Load RVM's capistrano plugin.
require "rvm/capistrano"

deployment_files = "/home/deploy/deployment_files/spaghettiprogramming.com"

server "127.0.0.1", :app, :web, :db, :primary => true
role :app, "127.0.0.1"
role :web, "127.0.0.1"
role :db, "127.0.0.1", :primary => true

set :rvm_ruby_string, 'ruby-1.9.2-p180'
set :rvm_type, :system  # Don't use system-wide RVM

set :application, 'spaghettiprogramming.com'     # you'll need to specify an app name
set :scm, "git"
set :repository, "git@github.com:MatthewRamirez/spaghettiprogramming.com.git"
set :branch, "master"
set :user, "deploy"
set :use_sudo, false
set :deploy_via, :remote_cache
set :deploy_to, "/var/www/spaghettiprogramming.com/"   # the destination dir
set :keep_releases, 3
set :copy_exclude, [".git", "spec"]

after "deploy:update_code",:preconfigure
desc "set up api passwords"
task :preconfigure do
  run "cp #{deployment_files}/application_config.yml #{shared_path}"
  run "ln -sf #{shared_path}/application_config.yml #{release_path}/config/application_config.yml"

  run "cp #{deployment_files}/database.yml #{shared_path}"
  run "ln -sf #{shared_path}/database.yml #{release_path}/config/database.yml"
end

namespace :deploy do
  task :start do
  end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy:restart", "deploy:cleanup"

load 'deploy/assets'
