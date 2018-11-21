# frozen_string_literal: true

module Thredded
  module Workgroup
    class MarkAllTopicsReadJob < ::ActiveJob::Base
      def perform(user)
        ::Thredded::Topic.unread(user).each do |topic|
          ::Thredded::UserTopicReadState.touch!(user.id, topic.last_post)
        end
      end
    end
  end
end
