#!/bin/bash
# Exit immediately if a command exits with a non-zero status
set -e

# Move to the app directory
cd /app

# Install dependencies and prepare the database
bundle exec rails db:prepare
bundle exec rails server -b 0.0.0.0