# frozen_string_literal: true

source "https://rubygems.org"

ruby File.read(".ruby-version")

gem "rails", "7.0.4"
gem "sprockets-rails"
gem "pg", "~> 1.4"
gem "puma", "~> 6.0"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "bootsnap", require: false

gem "pghero"
gem "pg_query"

group :development, :test do
  gem "dotenv-rails"
  gem "rspec-rails", ">= 6.0.1"
end

group :development do
  gem "license_finder", require: false
  gem "bundler-audit", require: false
  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "standard", "1.19.1", require: false
  gem "brakeman", require: false
  gem "fasterer", require: false
end

# lock until next working version: https://github.com/mikel/mail/issues/1541
gem "mail", "2.7.1"
