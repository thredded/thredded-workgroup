# frozen_string_literal: true

module Thredded
  module Workgroup
    module ViewHooks
      def topic_with_last_post
        @topic_with_last_post ||= TopicWithLastPost.new
      end

      # View hooks for a Topic when displaying last post.
      class TopicWithLastPost
        # @return [Thredded::AllViewHooks::ViewHook]
        attr_reader :last_post_with_controls

        # @return [Thredded::AllViewHooks::ViewHook]
        attr_reader :last_post

        def initialize
          @last_post_with_controls = Thredded::AllViewHooks::ViewHook.new
          @last_post = Thredded::AllViewHooks::ViewHook.new
        end
      end
    end
  end
end
