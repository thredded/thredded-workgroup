# frozen_string_literal: true
require "thredded/engine"
require "thredded/workgroup/thredded_route_delegator"
require "thredded/workgroup/route_delegator"
module Thredded
  module Workgroup
    class Engine < ::Rails::Engine
      isolate_namespace Thredded::Workgroup

      %w(app/controllers app/jobs app/view_models lib).each do |path|
        config.autoload_paths << File.expand_path("../../#{path}", File.dirname(__FILE__))
      end

      config.to_prepare do
        Rails.application.reload_routes!
        ::Thredded::Workgroup::ThreddedRouteDelegator.add_thredded_proxies
        ::Thredded::Workgroup::RouteDelegator.add_my_proxies_to_thredded
      end
      initializer "thredded.setup_assets" do
        Thredded::Workgroup::Engine.config.assets.precompile += %w(
          thredded-workgroup.css
        )
      end
    end
  end
end
