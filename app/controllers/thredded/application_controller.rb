# frozen_string_literal: true

require_dependency File.expand_path("../../app/controllers/thredded/application_controller",
                                    Thredded::Engine.called_from)

module Thredded
  module ApplicationControllerRetaining
    def topics_scope
      return super if messageboard_or_nil
      all_topics_scope
    end

    def unread_followed_topics_count
      return super if messageboard_or_nil
      all_unread_followed_topics_count
    end
  end
  class ApplicationController
    include Thredded::Workgroup::AllUnreadFollowedTopics

    prepend ::Thredded::ApplicationControllerRetaining
  end
end
