# frozen_string_literal: true

if Rails.env.production?
  Sentry.init do |config|
    config.dsn = ENV["SENTRY_DSN"]
    config.enabled_environments = ["production"]
    config.breadcrumbs_logger = [:active_support_logger]
    config.excluded_exceptions += ["Sentry::ExternalError"]
  end
end
