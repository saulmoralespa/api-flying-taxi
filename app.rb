require 'sinatra'
require './app/controllers/api_v1_controller'


class App < Sinatra::Base
    use ApiV1Controller
end