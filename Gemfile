source 'https://ruby.taobao.org/'

gem 'rake'
gem 'rack'
gem 'grape'
gem 'roar'
gem 'grape-roar'
gem 'rom-sql'
gem 'pg'
gem 'unicorn'
gem 'newrelic-grape'

group :production do
  gem 'newrelic-grape'
end

group :test do
  gem 'rack-test'
end

group :development, :test do
  gem 'dotenv'
  gem 'ffaker'
  gem 'rspec'
  gem 'byebug'
  gem 'database_cleaner'
  gem 'simplecov'
  gem 'cane'
  gem 'rubocop'
end
