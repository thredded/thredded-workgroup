# frozen_string_literal: true
module Thredded
  module PersonalizedNavigation
    module ThreddedRouteDelegator
      def self.add_thredded_proxies
        thredded = Thredded::Engine.routes.url_helpers
        path_methods = thredded.methods.select { |s| s.to_s.ends_with?("_path", "_url") }
        path_methods.each do |method_name|
          send(:define_method, method_name) do |*args|
            thredded.send(method_name, *args)
          end
        end
        ::Thredded::PersonalizedNavigation::ApplicationController.helper(
          ::Thredded::PersonalizedNavigation::ThreddedRouteDelegator
        )
      end
    end
  end
end
