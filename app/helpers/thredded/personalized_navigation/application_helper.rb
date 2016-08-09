# frozen_string_literal: true
module Thredded
  module PersonalizedNavigation
    module ApplicationHelper
      include Thredded::Engine.routes.url_helpers
      include Thredded::PersonalizedNavigation::Engine.routes.url_helpers

      def messageboard_link(messageboard)
        link_to messageboard.name, messageboard_path(messageboard)
      end
    end
  end
end
