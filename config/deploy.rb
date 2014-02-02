require 'bundler/capistrano'

default_run_options[:shell] = '/bin/bash'

deployment_files = "/home/deploy/deployment_files/spaghettiprogramming.com"

server "127.0.0.1", :app, :web, :db, :primary => true

role :app, "127.0.0.1"
role :web, "127.0.0.1"
role :db, "127.0.0.1", :primary => true

set :application, 'spaghettiprogramming.com'
set :scm, "git"
set :repository, "git@github.com:MatthewRamirez/spaghettiprogramming.com.git"
set :branch, "master"
set :user, "deploy"
set :use_sudo, false
set :deploy_via, :remote_cache
set :deploy_to, "/var/www/spaghettiprogramming.com"
set :keep_releases, 5
set :ssh_options, {:forward_agent => true}
set :ruby_version, "ruby-2.0.0-p247"
set :bundle_cmd, "/usr/local/bin/chruby-exec #{ruby_version} -- bundle"
set :rake,  "/usr/local/bin/chruby-exec #{ruby_version} -- bundle exec rake"

after "deploy:update_code",:preconfigure
before "deploy:assets:precompile", "bundle:install"

desc "set up passwords and configuration"
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

