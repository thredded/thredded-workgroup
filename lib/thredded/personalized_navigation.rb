# frozen_string_literal: true
require "thredded/personalized_navigation/engine"
require "thredded/personalized_navigation/version"

module Thredded
  module PersonalizedNavigation
    def self.navbar_class(params, target)
      "active" if current_for(params) == target
    end

    def self.current_for(params)
      if params[:controller].include?('personalized')
        params[:action].to_sym
      else
        :messageboards
      end
    end
  end
end
