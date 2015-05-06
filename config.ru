# This file is used by Rack-based servers to start the application.

require_relative 'lib/boot'

if ENV.fetch('RACK_ENV') == 'production'
  NewRelic::Agent.manual_start
end

run Rack::URLMap.new('/' => ProductStore::API.new)
