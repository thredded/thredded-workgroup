# frozen_string_literal: true
require_dependency "thredded/application_controller"
module Thredded
  module PersonalizedNavigation
    class ApplicationController < Thredded::ApplicationController
      protect_from_forgery with: :exception
    end
  end
end
