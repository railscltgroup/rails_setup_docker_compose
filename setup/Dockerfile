FROM ruby:3-alpine3.15

ENV POSTGRES postgresql postgresql-dev
ENV RAILS build-base tzdata ruby-nokogiri libcurl shared-mime-info
ENV YARN nodejs npm

RUN apk update && apk upgrade && \
    apk add $POSTGRES $RAILS $YARN && \
    rm /var/cache/apk/*

RUN gem install bundler:2.3.11

ENV APP_HOME /APP_NAME
WORKDIR $APP_HOME

COPY Gemfile $APP_HOME/Gemfile
COPY Gemfile.lock $APP_HOME/Gemfile.lock
RUN bundle install

RUN npm install -g yarn@1.22.18
COPY package.json $APP_HOME/package.json
COPY yarn.lock $APP_HOME/yarn.lock
RUN yarn install

COPY . $APP_HOME
