require 'yaml'
APP_CONFIG = YAML.load_file("#{Rails.root}/config/application_config.yml").with_indifferent_access[Rails.env]
