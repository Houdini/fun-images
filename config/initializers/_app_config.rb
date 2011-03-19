# Load application configuration
require 'ostruct'
require 'yaml'

config = YAML.load_file("#{Rails.root}/config/application.yml") || {}
app_config = config['common'] || {}
app_config.update(config[Rails.env] || {})
APP_CONFIG = OpenStruct.new app_config