# frozen_string_literal: true

Thredded::TopicsPageView.class_eval do
  prepend ::Thredded::Workgroup::TopicsPageViewWithLastPost
end
