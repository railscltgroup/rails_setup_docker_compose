FROM ruby:2.7.0-alpine3.10

ENV POSTGRES postgresql postgresql-dev
ENV RAILS build-base tzdata ruby-nokogiri libcurl
ENV YARN nodejs nodejs-npm

RUN apk update && apk upgrade && \
    apk add $POSTGRES $RAILS $YARN && \
    rm /var/cache/apk/*

RUN gem install bundler:2.1.2

ENV APP_HOME /APP_NAME
WORKDIR $APP_HOME

COPY Gemfile $APP_HOME/Gemfile
COPY Gemfile.lock $APP_HOME/Gemfile.lock
RUN bundle install

RUN npm install -g yarn@1.22.4
COPY package.json $APP_HOME/package.json
COPY yarn.lock $APP_HOME/yarn.lock
RUN yarn install

COPY . $APP_HOME
