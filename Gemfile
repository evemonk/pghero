# frozen_string_literal: true

source "https://rubygems.org"

ruby File.read(".ruby-version")

gem "railties", "7.0.1"
gem "actionpack", "7.0.1"
gem "actionview", "7.0.1"
gem "activemodel", "7.0.1"
gem "activerecord", "7.0.1"
gem "activesupport", "7.0.1"
gem "sprockets-rails"

gem "pg", "~> 1.1"
gem "puma", "~> 5.5"
gem "bootsnap", ">= 1.4.4", require: false
gem "rack-floc-off"
gem "pghero"
gem "pg_query"
gem "easymon"
gem "sentry-ruby"
gem "sentry-rails"
gem "newrelic_rpm"

group :development, :test do
  gem "dotenv-rails"
  gem "rspec-rails"
end

group :development do
  gem "listen", "~> 3.7"
  gem "license_finder", require: false
  gem "bundler-audit", require: false
  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "standard", require: false
  gem "brakeman", require: false
  gem "fasterer", require: false
end
