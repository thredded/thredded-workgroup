# frozen_string_literal: true
module Thredded
  module PersonalizedNavigation
    class ApplicationController < Thredded::ApplicationController
    end
  end
end
Thredded::ApplicationController.send(:helper, Thredded::PersonalizedNavigation::ApplicationHelper)
