source 'https://rubygems.org'

gem 'rails', '4.1.1'
gem 'rack', '1.5.2'
gem 'haml'
gem 'execjs'
gem 'jquery-rails'
gem 'pg'
gem 'less-rails'
gem 'paperclip', '~> 3.0'
gem 'redcarpet'
gem 'validates_email_format_of'
gem 'will_paginate'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'activerecord-session_store'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'twitter-bootstrap-rails',
    :git => 'https://github.com/seyhunak/twitter-bootstrap-rails.git',
    :branch => 'bootstrap3'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :development do
  gem 'annotate',
    :git => 'git://github.com/jeremyolliver/annotate_models.git',
    :branch => 'rake_compatibility'

  gem 'capistrano', '~> 2.15'
  gem 'meta_request', '0.2.0'
end

