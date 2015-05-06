#!/usr/bin/env bash
from twdevops/ruby:2.1
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
