FROM registry.docker.com/library/ruby:3.3.4-slim@sha256:0f5c785e2189ab9ffda522b20c0380dbc51d9991361f9e0bfbcf46bb68d32b29 as base

LABEL maintainer="Igor Zubkov <igor.zubkov@gmail.com>"

# Rails app lives here
WORKDIR /rails

# Set production environment
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development:test" \
    BOOTSNAP_LOG="true" \
    BOOTSNAP_READONLY="true" \
    RUBY_YJIT_ENABLE="1"

RUN set -eux; \
    gem update --system "3.5.15" ; \
    gem install bundler --version "2.5.15" --force ; \
    gem --version ; \
    bundle --version

# Throw-away build stage to reduce size of final image
FROM base as build

# Install packages needed to build gems
# skipcq: DOK-DL3008
RUN set -eux; \
    apt-get update -qq ; \
    apt-get dist-upgrade -qq ; \
    apt-get install --no-install-recommends -y build-essential git libpq-dev pkg-config shared-mime-info

# Install application gems
COPY .ruby-version Gemfile Gemfile.lock ./
RUN set -eux; \
    bundle install ; \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git ; \
    bundle exec bootsnap precompile --gemfile

# Copy application code
COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/ config/ Rakefile

# Precompiling assets for production without requiring secret RAILS_MASTER_KEY
# skipcq: DOK-W1001
RUN SECRET_KEY_BASE_DUMMY=1 \
    DATABASE_URL="postgres://postgres@postgresql/evemonk_production?pool=1&encoding=unicode" \
    ./bin/rails assets:precompile

# Final stage for app image
FROM base

# Install packages needed for deployment
# skipcq: DOK-DL3008
RUN set -eux; \
    apt-get update -qq ; \
    apt-get dist-upgrade -qq ; \
    apt-get install --no-install-recommends -y curl postgresql-client libjemalloc2 shared-mime-info ; \
    apt-get autoremove -y ; \
    apt-get clean -y ; \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copy built artifacts: gems, application
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Run and own only the runtime files as a non-root user for security
RUN set -eux; \
    useradd rails --create-home --shell /bin/bash ; \
    chown -R rails:rails db log tmp

USER rails:rails

ENV LD_PRELOAD="libjemalloc.so.2"

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 80/tcp

CMD ["./bin/thrust", "./bin/rails", "server"]
