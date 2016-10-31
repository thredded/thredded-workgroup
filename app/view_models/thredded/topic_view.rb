# frozen_string_literal: true
require_dependency File.expand_path("../../app/view_models/thredded/topic_view", Thredded::Engine.called_from)
module Thredded
  class TopicView < Thredded::BaseTopicView
    def path
      Thredded::UrlsHelper.topic_path(@topic, page: @read_state.page, anchor: @topic.last_post && "post_#{@topic.last_post.id}")
    end
  end
end
