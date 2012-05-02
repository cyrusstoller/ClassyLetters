# Load the rails application
require File.expand_path('../application', __FILE__)

APP_CONFIG = YAML.load_file("#{Rails.root.to_s}/config/config.yml")

# Initialize the rails application
ClassyLetters::Application.initialize!
