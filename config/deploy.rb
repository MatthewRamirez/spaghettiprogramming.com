# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'spaghettiprogramming.com'
set :deploy_user, 'deploy'

set :scm, :git
set :repo_url, 'git@github.com:MatthewRamirez/spaghettiprogramming.com.git'

set :chruby_ruby, 'ruby-2.1.2'

set :keep_releases, 5

set :config_files, %w{/home/deploy/deployment_files/spaghettiprogramming.com/database.yml /home/deploy/deployment_files/spaghettiprogramming.com/application_config.yml}
set :linked_files, %w{config/database.yml config/application_config.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :tests, []

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  before :deploy, "deploy:check_revision"
  before :deploy, "deploy:run_tests"
  after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

end
