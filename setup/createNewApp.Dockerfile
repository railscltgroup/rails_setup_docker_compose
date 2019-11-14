FROM ruby:2.6.4-alpine3.10

ARG APP_NAME=myapp

ENV POSTGRES postgresql postgresql-dev
ENV RAILS build-base tzdata ruby-nokogiri libcurl
ENV YARN nodejs nodejs-npm

RUN echo "Add software for Rails, Yarn, and Postgres"
RUN apk update && apk upgrade && \
    apk add $POSTGRES $RAILS $YARN && \
    rm /var/cache/apk/*

RUN npm install -g yarn@1.17.0

RUN gem install bundler -v 2.0.2
RUN gem install rails -v 6.0.1

ENV APP_HOME /docker-build
WORKDIR $APP_HOME

RUN echo "Create a Rails App"
RUN rails new $APP_NAME --database=postgresql

RUN echo "Add database file"
COPY setup/database.yml $APP_HOME/$APP_NAME/config/database.yml
RUN sed -i "s/APP_NAME/${APP_NAME}/g" $APP_HOME/$APP_NAME/config/database.yml

RUN echo "Add docker-compose file"
COPY setup/docker-compose.yml $APP_HOME/$APP_NAME/docker-compose.yml
RUN sed -i "s/APP_NAME/${APP_NAME}/g" $APP_HOME/$APP_NAME/docker-compose.yml

RUN echo "Add Dockerfile"
COPY setup/Dockerfile $APP_HOME/$APP_NAME/Dockerfile
RUN sed -i "s/APP_NAME/${APP_NAME}/g" $APP_HOME/$APP_NAME/Dockerfile

RUN echo "Add dockerignore file"
COPY setup/.dockerignore $APP_HOME/$APP_NAME/.dockerignore
