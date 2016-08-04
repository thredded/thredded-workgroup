# frozen_string_literal: true
module Thredded
  module PersonalizedNavigation
    class ApplicationController < Thredded::ApplicationController
      protect_from_forgery with: :exception
    end
  end
end
