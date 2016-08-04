# frozen_string_literal: true
module Thredded
  module PersonalizedNavigation
    class Engine < ::Rails::Engine
      isolate_namespace Thredded::PersonalizedNavigation

      %w(app/controllers app/jobs lib).each do |path|
        config.autoload_paths << File.expand_path("../../#{path}", File.dirname(__FILE__))
      end
    end
  end
end
