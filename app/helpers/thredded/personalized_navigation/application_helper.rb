# frozen_string_literal: true
module Thredded
  module PersonalizedNavigation
    module ApplicationHelper
      include Thredded::Engine.routes.url_helpers
      include Thredded::PersonalizedNavigation::Engine.routes.url_helpers

      def thredded_navbar_class(current)
        return "active" if thredded_navbar_active == current
        nil
      end
    end
  end
end
