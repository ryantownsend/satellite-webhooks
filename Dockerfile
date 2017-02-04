FROM ruby:2.4-slim
LABEL maintainer "ryan@ryantownsend.co.uk"

# Install basic packages
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  build-essential \
  curl \
  git \
  libpq-dev

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
