# frozen_string_literal: true

module Thredded
  module Workgroup
    module PostsControllerWhichRedirects
      def create
        @post_form = Thredded::PostForm.new(
          user: thredded_current_user, topic: parent_topic, post_params: new_post_params
        )
        authorize_creating @post_form.post

        if @post_form.save
          # TODO: extract as a hook on thredded#posts_controller `after_create(post)`
          redirect_after_create(@post_form.post)
        else
          render :new
        end
      end

      private

      def after_mark_as_unread
        if post.private_topic_post?
          redirect_to private_topics_path
        else
          redirect_to thredded_workgroup.unread_nav_path
        end
      end

      def redirect_after_create(post)
        UserTopicReadState.touch!(thredded_current_user.id, post)
        if params[:post_referer].present?
          redirect_to params[:post_referer], notice: generate_flash_for(post)
        else
          redirect_to thredded_workgroup.unread_nav_path, notice: generate_flash_for(post)
        end
      end

      def generate_flash_for(post)
        path_to_post = thredded.messageboard_topic_path(parent_topic.messageboard, parent_topic,
                                                        anchor: "post_#{post.id}")
        # rubocop:disable Rails/OutputSafety
        "Successfully replied to #{view_context.link_to(parent_topic.title, path_to_post)}".html_safe
        # rubocop:enable Rails/OutputSafety
      end
    end
  end
end
