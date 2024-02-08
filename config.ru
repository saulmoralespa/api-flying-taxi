# config.ru

require 'dotenv/load'
require 'sinatra'
require 'sequel'
require './app'

require './config/application'

run App