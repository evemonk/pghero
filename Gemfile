# frozen_string_literal: true

source "https://rubygems.org"

ruby File.read(".ruby-version")

gem "rails", "7.0.1"
gem "sprockets-rails"
gem "pg", "~> 1.3"
gem "puma", "~> 5.6"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "bootsnap", require: false

gem "rack-floc-off"
gem "pghero"
gem "pg_query"
gem "sentry-ruby"
gem "sentry-rails"
gem "newrelic_rpm"

group :development, :test do
  gem "dotenv-rails"
  gem "rspec-rails"
end

group :development do
  gem "license_finder", require: false
  gem "bundler-audit", require: false
  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "standard", require: false
  gem "brakeman", require: false
  gem "fasterer", require: false
end
