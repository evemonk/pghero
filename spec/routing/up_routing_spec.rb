# frozen_string_literal: true

require "rails_helper"

describe Rails::HealthController do
  describe "routing" do
    it "should route GET /up to rails/health#show" do
      expect(get: "/up").to route_to(
        controller: "rails/health",
        action: "show"
      )
    end
  end
end
