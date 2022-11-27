# frozen_string_literal: true

module Thredded
  module Workgroup
    module ApplicationControllerRetaining
      def topics_scope
        return super if messageboard_or_nil

        all_topics_scope
      end

      def unread_followed_topics_count
        return super if messageboard_or_nil

        all_unread_followed_topics_count
      end
    end
  end
end
