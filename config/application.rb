require 'active_record'
require 'yaml'
require 'dotenv/load'


config_path = File.join(__dir__, 'database.yml')
config_content = File.read(config_path)

config = YAML.safe_load(config_content, aliases: true)
ActiveRecord::Base.configurations = config
ActiveRecord::Base.establish_connection(:development)


Dir["#{__dir__}/../app/models/*.rb"].each { |file| require file }