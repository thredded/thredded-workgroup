# frozen_string_literal: true

require_dependency File.expand_path("../../app/view_models/thredded/topic_view", Thredded::Engine.called_from)
module Thredded
  class TopicView < Thredded::BaseTopicView
    def path
      anchor = if @read_state.first_unread_post_page
                 "unread"
               elsif @topic.last_post
                 "post_#{@topic.last_post.id}"
               end
      page = @read_state.first_unread_post_page || @read_state.last_read_post_page
      Thredded::UrlsHelper.topic_path(@topic, page: page, anchor: anchor)
    end

    def reply_path
      Thredded::UrlsHelper.topic_path(@topic, page: last_page, anchor: "new_post")
    end

    def mark_as_unread_path
      Thredded::UrlsHelper.mark_as_unread_post_path(last_post, format: :json)
    end

    def mark_as_read_path
      Thredded::UrlsHelper.mark_as_read_post_path(last_post, format: :json)
    end

    def last_page
      (@topic.posts_count / Thredded.posts_per_page.to_f).ceil # TODO: doesn't account for visibility
    end
  end
end
