# This Dockerfile is designed for production, not development. Use with Kamal or build'n'run by hand:
# docker build -t pghero .
# docker run -d -p 80:80 --name pghero pghero

# For a containerized dev environment, see Dev Containers: https://guides.rubyonrails.org/getting_started_with_devcontainer.html

FROM registry.docker.com/library/ruby:3.4.2-slim@sha256:cdc00623487445d99f3de3923b97463a15e2ce9045ea679f224f361eec7512c1 AS base

LABEL maintainer="Ihor Zubkov <igor.zubkov@gmail.com>"

# Rails app lives here
WORKDIR /rails

# Install base packages
RUN set -eux; \
    apt-get update -qq ; \
    apt-get dist-upgrade -qq ; \
    apt-get install --no-install-recommends -y curl libjemalloc2 postgresql-client shared-mime-info ; \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Set production environment
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development" \
    BOOTSNAP_LOG="true" \
    BOOTSNAP_READONLY="true"

RUN set -eux; \
    gem update --system "3.6.5" ; \
    gem install bundler --version "2.6.5" --force

# Throw-away build stage to reduce size of final image
FROM base AS build

# Install packages needed to build gems
RUN set -eux; \
    apt-get update -qq ; \
    apt-get install --no-install-recommends -y build-essential git libpq-dev pkg-config libyaml-dev ; \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

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
RUN SECRET_KEY_BASE_DUMMY=1 \
    DATABASE_URL="postgres://postgres@postgresql/evemonk_production?pool=1&encoding=unicode" \
    ./bin/rails assets:precompile

# Final stage for app image
FROM base

# Copy built artifacts: gems, application
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Run and own only the runtime files as a non-root user for security
RUN set -eux; \
    groupadd --system --gid 1000 rails ; \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash ; \
    chown -R rails:rails db log tmp

USER 1000:1000

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Start server via Thruster by default, this can be overwritten at runtime
EXPOSE 80/tcp

CMD ["./bin/thrust", "./bin/rails", "server"]
