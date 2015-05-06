Product Service
============

product micro service which provides the following capability:
* Add a product
* View all products
* View a product details
* Update a product

# Development Environment

### Set up your .env file
```
cat << EOF > .env
PRODUCTS_DB_URL=<REPLACE>
PRODUCTS_DB_USERNAME=<REPLACE>
PRODUCTS_DB_PASSWORD=<REPLACE>
EOF
```
Replace the placeholder with the detail of the environment you are connecting to.
_hint_: If the password contains special characters, surround them with `"`

### Up and Running

1. Install postgres `brew install postgresql`
2. Create database `createdb products_development products_test`
3. Install specified ruby version (in `.ruby-version`).
4. `bundle install`
5. Make sure postgres is up and running.
6. `createdb products_test && createdb products_development && createdb products` 
7. `rake db:migrate` or just `rake db:reset`
8. `rackup`

## Code Quality (Static Analysis)

Code complexity metrics provided by [Cane](https://github.com/square/cane):

    rake quality

Code format and convention check provided by [Rubocop](https://github.com/bbatsov/rubocop):

    rake rubocop

## Test Suite

To run the entire test suite (including functional tests):

    rake

### Test Coverage

If you would like a report of the test coverage, open "coverage/index.html" after running following task:

    rake spec

