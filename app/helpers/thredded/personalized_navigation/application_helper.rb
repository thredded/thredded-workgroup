# frozen_string_literal: true
module Thredded
  module PersonalizedNavigation
    module ApplicationHelper
      include Thredded::Engine.routes.url_helpers
      include Thredded::PersonalizedNavigation::Engine.routes.url_helpers
    end
  end
end
