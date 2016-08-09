# frozen_string_literal: true
module Thredded
  module PersonalizedNavigation
    class TopicView < ::Thredded::TopicView
      delegate :messageboard,
               to: :@topic
    end
  end
end
