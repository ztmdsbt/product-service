require 'rubygems'
require 'bundler'

ENV['RACK_ENV'] ||= ENV.fetch('RACK_ENV', 'development')

if ENV['RACK_ENV'] != 'production'
  require 'ffaker'
  require 'dotenv'
  Dotenv.load
end

Bundler.require(:default, ENV['RACK_ENV'].to_sym)

$LOAD_PATH.unshift File.expand_path('.', File.dirname(__FILE__))
$LOAD_PATH.unshift File.expand_path('../app', File.dirname(__FILE__))
$LOAD_PATH.unshift File.expand_path('../config', File.dirname(__FILE__))

require 'logging'
require 'roar/representer'
require 'roar/json'
require 'roar/json/hal'
require 'version'
require 'models/product'
require 'validators/product_creation_validator'
require 'validators/product_updating_validator'
require 'database'
require 'repositories/record_not_found_error'
require 'repositories/record_invalid_error'
require 'repositories/product_repository'
require 'representers/product_representer'
require 'representers/products_representer'
require 'helpers/shared_params'
require 'api'
