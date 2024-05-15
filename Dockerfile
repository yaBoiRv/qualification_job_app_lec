# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.2.2
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# Rails app lives here
WORKDIR /app

# Set production environment
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITH="development"

# Install system dependencies and PostgreSQL client libraries in base image
RUN apt-get update -qq && apt-get install -y libpq-dev curl && rm -rf /var/lib/apt/lists/*

# Install Node.js and Yarn
RUN curl -sS https://deb.nodesource.com/setup_18.x | bash && \
    apt-get install -y nodejs && \
    npm install -g npm@latest && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && apt-get install -y yarn && \
    rm -rf /var/lib/apt/lists/*

# Throw-away build stage to reduce size of final image
FROM base as build

# Install system dependencies
RUN apt-get update -qq && apt-get install -y build-essential git libvips postgresql-client dos2unix

# Ensure `npx` is installed
RUN npm --version && npx --version

# Copy over the application source code
COPY . /app

# Update Browserslist database
RUN npx update-browserslist-db@latest
RUN npm install --check-files

# Install the correct version of Bundler
RUN gem install bundler -v '~> 2.5'

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy application code
COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# Precompile assets for production without requiring secret RAILS_MASTER_KEY
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# Final stage for app image
FROM base

# Copy built artifacts: gems, application
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /app /app

# Set the path for the Rails application
ENV PATH="/app/bin:${PATH}"

# Run and own only the runtime files as a non-root user for security
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER rails:rails

COPY --chmod=+x entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./bin/rails", "server"]
