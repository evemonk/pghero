# frozen_string_literal: true

source "https://rubygems.org"

ruby file: ".ruby-version"

gem "rails", "8.0.0.beta1"
gem "propshaft"
gem "pg"
gem "puma"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:windows, :jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", ">= 2.0.0.rc2", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

gem "pghero"
gem "pg_query"
gem "pry-rails"
gem "sshkit", require: false

gem "uri", ">= 0.12.2"

group :development, :test do
  gem "brakeman", require: false
  gem "rspec-rails", ">= 6.0.1"
end

group :development do
  gem "license_finder", require: false
  gem "rubocop", require: false
  gem "rubocop-disable_syntax", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "rubocop-rspec_rails", require: false
  gem "standard", "1.41.0", require: false
  gem "fasterer", require: false
  gem "bundler-audit", require: false
end

group :test do
  gem "simplecov", require: false
end
