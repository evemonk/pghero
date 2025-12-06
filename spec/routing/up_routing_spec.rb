# frozen_string_literal: true

require "rails_helper"

RSpec.describe Rails::HealthController, type: :routing do
  describe "routing" do
    it "should route GET /up to rails/health#show" do
      expect(get: "/up").to route_to(
        controller: "rails/health",
        action: "show"
      )
    end
  end
end
