# frozen_string_literal: true
module Thredded
  module PersonalizedNavigation
    module ApplicationHelper
      def messageboard_link(messageboard)
        link_to messageboard.name, thredded.messageboard_topics_path(messageboard)
      end
    end
  end
end
