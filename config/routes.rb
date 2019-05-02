# frozen_string_literal: true

Rails.application.routes.draw do
  mount PgHero::Engine, at: '/'
end
