FROM the-money-docker-registry.test.corp.realestate.com.au/hydra/ubuntu-ruby2.1
MAINTAINER Products <productgroupplatform@rea-group.com>

RUN mkdir /app

RUN apt-get update -y
RUN apt-get install -y libpq-dev postgresql-client

WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install --jobs 8 --retry 3

ADD . /app

EXPOSE 80

CMD bin/run
