#! /bin/sh

wait-for-it "postgresql:5432" -- echo "PostgreSQL up and running"

bundle exec puma -C config/puma.rb
