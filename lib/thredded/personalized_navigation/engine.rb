# frozen_string_literal: true
module Thredded
  module PersonalizedNavigation
    class Engine < ::Rails::Engine
      isolate_namespace Thredded::PersonalizedNavigation

      %w(app/controllers app/jobs lib).each do |path|
        config.autoload_paths << File.expand_path("../../#{path}", File.dirname(__FILE__))
      end

      initializer "thredded.setup_assets" do
        Thredded::PersonalizedNavigation::Engine.config.assets.precompile += %w(
          thredded-personalized-navigation.css
        )
      end
    end
  end
end
