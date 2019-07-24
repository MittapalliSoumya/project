FROM ruby:2.6.2-stretch

## copy the app
COPY test-interview-question-master /Application/

##creates the working directory
WORKDIR /Application/test-interview-question-master

#defining environments  based on the app.All apps are considered production environments
ENV RAILS_ENV production
ENV SECRET_KEY_BASE "592d158408665d844c5246f15cb8a3048631f824084a42769e3cf4442f605325c3932795448dd255862aad2b2de8681bede2afe57e8aea45b51b0b4859200ec8"

RUN bundle install --deployment --without test \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt install -y nodejs \
    && bundle exec rake assets:precompile

ENTRYPOINT ["bundle","exec", "rails", "server"]