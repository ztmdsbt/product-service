product Store
============

product micro service which provides the following capability:
* Add a product
* View all products
* View a product details

## SOX requirements

Specify whether this repo has financial implications and is part of SOX requirements, or not.

## Service Level Agreements (SLA)

* Availability Window
  - 
* Performance/response time during Availability Window
  - 
* Availability - 

## Usage

### Prod

* http://example.realestate.com.au
* Access restrictions
  * requires prod VPN
  * membership of AcmeWidgets LDAP group

### Test

* http://product-store.test.corp.realestate.com.au/
* Access restrictions
  * requires corporate network [ or BiQ VLAN, etc]

# Development Environment

### Set up your .env file
```
cat << EOF > .env
CUSTOMER_DB_URL=<REPLACE>
CUSTOMER_DB_USERNAME=<REPLACE>
CUSTOMER_DB_PASSWORD=<REPLACE>
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
6. `rake db:migrate` or just `rake db:reset`
7. `rackup`

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

## Change release process

Steps for change release, eg:

* Create code on feature branch or forked repository.
* Provide a Pull Request for merging into master and get a :thumbsup: from one of the custodians external to the work you have completed.
* Deploy in accordance with deployment steps below.

# Deployment

### Create RDS
```
cd deploy
./create-rds.sh <test|prod>
```
### Create IAM Role for app and grant access to KMS key

The app requires access to a KMS key to decrypt the database credentials.
We have to do a little two step because CloudFormation doesn't (yet)
have support for KMS.

1. Create the role and get its ID.
```
cd deploy
./create-iam-role.sh <test|prod>
```
1. Grant the role access to the KMS key:
```
aws kms create-grant --key-id 89cb1887-4448-4ecb-870d-9e1105688fe2 --operations Decrypt --grantee-principal IAM_ROLE_ARN_FROM_PREVIOUS_STEP_OUTPUT
```
1. Update rea-shipper config with the IAM_ROLE_ID output by script in step 1.
```
iam:
  instances:
    iam_role: product-store-iam-role-IamRole-XXXXXXXXXXXX
```

### KMS SECRET ENCODING

1. Encrypt creds
```
echo "CUSTOMER_DB_URL=XXXXX CUSTOMER_DB_USERNAME=XXXXX CUSTOMER_DB_PASSWORD=XXXXX" | bundle exec ssssh encrypt --no-wrap 89cb1887-4448-4ecb-870d-9e1105688fe2
```
1. Encode cypher text
```
echo <cyphertext> | base64
```
1. Update the rea-shipper config with the KMS_SECRET_ENCODED cypher text output from last step
```
app:
  environment:
    KMS_SECRET_ENCODED: <encoded cyphertext>
```

## Troubleshooting

### Logs

* Logs are available at Splunk (url)
  * Show errors [`index=biq my_app error`](https://splunk.eqx.realestate.com.au:8000/en-US/app/BIQ/flashtimeline/?q=search%20index%3Dbiq%20my_app%20error&earliest=-24h%40h&latest=now)

# Custodian

products Team customergroupplatform@rea-group.com
