#!/usr/bin/env bash
# exit on error
set -o errexit

apt-get install -y imagemagick

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean

