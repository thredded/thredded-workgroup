# frozen_string_literal: true
require_dependency File.expand_path("../../app/view_models/thredded/topics_page_view", Thredded::Engine.called_from)
module Thredded
  module TopicsPageViewWithLastPost
    protected

    def decorate_scope(topics_page_scope)
      super.includes(:last_post)
    end
  end

  class TopicsPageView
    prepend ::Thredded::TopicsPageViewWithLastPost
  end
end
