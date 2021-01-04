# frozen_string_literal: true

source "https://rubygems.org"

ruby File.read(".ruby-version")

gem "rails", "~> 6.1.0"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "bootsnap", ">= 1.4.4", require: false
gem "activerecord-nulldb-adapter"
gem "pghero"
gem "pg_query"
gem "easymon"

group :development, :test do
  gem "dotenv-rails"
  gem "bundler-audit", require: false
  gem "bundler-leak", require: false
  gem "brakeman", require: false
  # gem "fasterer", require: false
end

group :development do
  gem "listen", "~> 3.4"
  gem "standard", require: false
  gem "license_finder", require: false
end
