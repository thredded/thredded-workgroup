# frozen_string_literal: true

require "thredded/engine"

module Thredded
  module Workgroup
    class Engine < ::Rails::Engine
      isolate_namespace Thredded::Workgroup

      # https://guides.rubyonrails.org/engines.html#overriding-models-and-controllers
      overrides = root.join("lib/overrides")
      # Rails::autoloaders.main.ignore(overrides)
      config.to_prepare do
        Dir.glob("#{overrides}/**/*_override.rb").each do |override|
          Rails.logger.debug { "overriding: #{override}" }
          load override
        end
      end

      config.to_prepare do
        Rails.application.reload_routes!

        Thredded::ApplicationController.module_eval do
          Thredded.view_hooks.post_form.content_text_area.config.before do |form:, **_args|
            if form.object.is_a?(Thredded::PostForm) && form.object.topic.persisted?
              render partial: "thredded/topics/followers", locals: { topic: form.object.topic }
            end
          end
        end
      end
      initializer "thredded_workgroup.setup_assets" do
        Thredded::Workgroup::Engine.config.assets.precompile += %w(
          thredded_workgroup_manifest.js
        )
      end
    end
  end
end
