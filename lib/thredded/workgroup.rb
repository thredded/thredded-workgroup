# frozen_string_literal: true

require "thredded/workgroup/engine"
require "thredded/workgroup/version"

module Thredded
  module Workgroup
    def self.navbar_class(params, target)
      "active" if current_for(params) == target
    end

    def self.current_for(params)
      if params[:controller].include?("workgroup") # TODO: make this better
        params[:action].to_sym
      else
        :messageboards
      end
    end
  end
end
