source 'https://rubygems.org'

gem 'rails', '~> 4.2'
gem 'rack'
gem 'haml'
gem 'execjs'
gem 'jquery-rails'
gem 'pg'
gem 'less-rails'
gem 'paperclip', '~> 3.0'
gem 'redcarpet'
gem 'validates_email_format_of'
gem 'will_paginate'
gem 'bcrypt-ruby', '~> 3.1'
gem 'activerecord-session_store'
gem 'twitter-bootstrap-rails',
  :git => 'https://github.com/seyhunak/twitter-bootstrap-rails.git',
  :branch => 'bootstrap3'
gem 'puma'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier'
  gem 'bootstrap-sass'
  gem 'coffee-script'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :development do
  gem 'annotate',
    :git => 'git://github.com/jeremyolliver/annotate_models.git',
    :branch => 'rake_compatibility'

  gem 'capistrano', '~> 3.1.0'
  gem 'capistrano-rails', '~> 1.1.0'
  gem 'capistrano-bundler'
  gem 'capistrano-chruby', '~> 0.1.1'
  gem 'byebug'
end

