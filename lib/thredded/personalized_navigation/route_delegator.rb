# frozen_string_literal: true

# This includes this module into Thredded Application Controller so we can use
# url helpers from Thredded PN like unread_nav_path in controllers.
module Thredded
  module PersonalizedNavigation
    module RouteDelegator
      def self.add_my_proxies_to_thredded
        thredded_methods = Thredded::Engine.routes.url_helpers.methods
        my_route_helpers = Thredded::PersonalizedNavigation::Engine.routes.url_helpers
        path_methods = my_route_helpers.methods.select { |s| s.to_s.ends_with?("_path", "_url") }
          .reject{|s| thredded_methods.include?(s)}
        path_methods.each do |method_name|
          send(:define_method, method_name) do |*args|
            my_route_helpers.send(method_name, *args)
          end
        end
        ::Thredded::ApplicationController.send(:include,
          ::Thredded::PersonalizedNavigation::RouteDelegator
        )
        # if we need to use in views, then we add
        # ::Thredded::ApplicationController.helper(::Thredded::PersonalizedNavigation::RouteDelegator)

      end
    end
  end
end
