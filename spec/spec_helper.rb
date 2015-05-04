ENV['RACK_ENV'] = 'test'
# Load simplecov unless running pact
unless defined? Pact
  require 'simplecov'
  SimpleCov.start do
    add_filter 'spec'
    add_filter 'lib'

    add_group 'Models',       'app/models'
    add_group 'Repositories', 'app/repositories'
    add_group 'Representers', 'app/representers'
    add_group 'Helpers',      'app/helpers'

    minimum_coverage 100
  end
end

require 'rubygems'
require 'bundler'
Bundler.require(:default, ENV['RACK_ENV'].to_sym)
$LOAD_PATH.unshift File.expand_path('../app', File.dirname(__FILE__))
$LOAD_PATH.unshift File.expand_path('../config', File.dirname(__FILE__))
require 'version'
require 'boot'
require 'models/product'
require 'database'
require 'repositories/record_not_found_error'
require 'repositories/record_invalid_error'
require 'repositories/product_repository'
require 'helpers/shared_params'
require 'api'
require 'rack/test'
require 'database_cleaner'
require 'support/model_factory'
require 'support/param_factory'
require 'support/custom_matchers'

RSpec.configure do |config|
  config.include CustomMatchers
  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    # be_bigger_than(2).and_smaller_than(4).description
    #   # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #   # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |_mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
  end

  DatabaseCleaner[:sequel, { connection: Database.setup_connection.default.connection }]

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with :truncation
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
