# frozen_string_literal: true

module Thredded
  module Workgroup
    module AllUnreadFollowedTopics
      include Pundit
      extend ActiveSupport::Concern
      included do
        helper_method :all_unread_followed_topics_count
      end

      # @return [ActiveRecord::Relation]
      def all_topics_scope
        @all_topics_scope ||=
          policy_scope(Thredded::Topic.all).joins(:messageboard).merge(policy_scope(Thredded::Messageboard.all))
      end

      # @return Integer
      def all_unread_followed_topics_count
        @all_unread_followed_topics_count ||=
          if thredded_signed_in?
            all_topics_scope.unread_followed_by(thredded_current_user).count
          else
            0
          end
      end

      # need to define `thredded_current_user` and possibly `pundit_user`
    end
  end
end
