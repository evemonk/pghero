# frozen_string_literal: true

source "https://rubygems.org"

gem "rails", "~> 6.0.0"
gem "pg", ">= 0.18", "< 2.0"
gem "puma"
gem "bootsnap", ">= 1.4.2", require: false
gem "activerecord-nulldb-adapter"
gem "pghero"
gem "pg_query"
gem "easymon"

group :development, :test do
  gem "dotenv-rails"
  gem "bundler-audit", require: false
  gem "bundler-leak", require: false
  gem "brakeman", require: false
  gem "fasterer", require: false
end

group :development do
  gem "listen", "~> 3.2"
  gem "standard", require: false
  gem "license_finder", require: false
end
