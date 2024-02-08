require 'rack/test'
require 'rspec'
require 'geocoder'
require 'json'
require_relative '../app'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  def app
    App
  end
end