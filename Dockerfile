FROM ruby:2.4-slim
LABEL maintainer "ryan@ryantownsend.co.uk"

# Install essentials and cURL
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  build-essential \
  curl

# Add the NodeJS source
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -

# Add the Yarn source
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install basic packages
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  git \
  libpq-dev \
  nodejs \
  yarn

# Install yarn
RUN npm install yarn

# Configure the main working directory
ENV app /app
RUN mkdir $app
WORKDIR $app

# Set the where to install gems
ENV GEM_HOME /rubygems
ENV BUNDLE_PATH /rubygems

# Link the whole application up
ADD . $app

# Ensure our gems are installed when running commands
ENTRYPOINT bin/docker/entrypoint $0 $@
