# frozen_string_literal: true
require_dependency File.expand_path(
  "../../app/controllers/thredded/application_controller", Thredded::Engine.called_from
)
module Thredded
  class ApplicationController < ::ApplicationController # reopening
    helper Thredded::PersonalizedNavigation::ApplicationHelper
    helper_method :thredded_navbar_active
    def thredded_navbar_active
      :messageboards
    end
  end
end
