# frozen_string_literal: true
require "thredded/engine"
require_dependency "thredded/personalized_navigation/thredded_route_delegator"
require_dependency "thredded/personalized_navigation/route_delegator"
module Thredded
  module PersonalizedNavigation
    class Engine < ::Rails::Engine
      isolate_namespace Thredded::PersonalizedNavigation

      %w(app/controllers app/jobs app/view_models lib).each do |path|
        config.autoload_paths << File.expand_path("../../#{path}", File.dirname(__FILE__))
      end

      config.to_prepare do
        Rails.application.reload_routes!
        ::Thredded::PersonalizedNavigation::ThreddedRouteDelegator.add_thredded_proxies
        ::Thredded::PersonalizedNavigation::RouteDelegator.add_my_proxies_to_thredded
      end
      initializer "thredded.setup_assets" do
        Thredded::PersonalizedNavigation::Engine.config.assets.precompile += %w(
          thredded-personalized-navigation.css
        )
      end
    end
  end
end
