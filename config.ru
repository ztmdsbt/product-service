# This file is used by Rack-based servers to start the application.

require_relative 'lib/boot'
require_relative 'config/health_check.rb'

use Rack::HalBrowser::Redirect, :exclude => ['/diagnostic', '/service-info', '/trace']

if ENV.fetch('RACK_ENV') == 'production'
  NewRelic::Agent.manual_start
end

map '/diagnostic' do
  run REA::HealthCheck::DiagnosticApp
end

run HAL::Index.new(
  'self' => {
    href: '/', app: ProductStore::API, title: 'Index'
  }
)

HAL::Index.register_rel 'products', href: '/products', title: 'products'
