# frozen_string_literal: true

Thredded::ApplicationController.class_eval do
  Rails.logger.debug "I am being evaled Thredded::ApplicationController"
  include Thredded::Workgroup::AllUnreadFollowedTopics

  prepend ::Thredded::Workgroup::ApplicationControllerRetaining
end
