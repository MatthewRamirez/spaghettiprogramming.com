require 'yaml'
APP_CONFIG = YAML.load_file("#{Rails.root}/config/application_config.yml").with_indifferent_access[Rails.env]

#Change the default BCrypt cost used for has_secure_password
require 'bcrypt'
BCrypt::Engine::DEFAULT_COST = 12
