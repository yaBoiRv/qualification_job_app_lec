#!/bin/bash
# Exit immediately if a command exits with a non-zero status
set -e

# Check if the database exists
bundle exec rails db:prepare

# Start the Rails server
exec "$@"