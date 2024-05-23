# frozen_string_literal: true

namespace :db do
  desc 'Clear all records from the database'
  task clear_all: :environment do
    ActiveRecord::Base.connection.tables.each do |table|
      # Avoid truncating metadata tables
      next if %w[schema_migrations ar_internal_metadata].include?(table)

      # Truncate each table, reset identity, and cascade to maintain relationships
      ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table} RESTART IDENTITY CASCADE")
    end
  end
end
# use with caution
# run - 'rails db:clear_all'
