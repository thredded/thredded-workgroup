# frozen_string_literal: true

module Thredded
  module Workgroup
    module TopicsPageViewWithLastPost
      protected

      def refine_scope(topics_page_scope)
        super.includes(:last_post)
      end
    end
  end
end
