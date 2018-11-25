module Thredded
  module Workgroup
    module ViewHooks
      attr_reader :topic_with_last_post

      def initialize
        super
        @topic_with_last_post = TopicWithLastPost.new
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
