# frozen_string_literal: true

module Thredded
  module Workgroup
    class Paginator < Kaminari::Helpers::Paginator
      module UrlFixer
        def page_url_for(page)
          params = params_for(page)
          params[:only_path] = true
          @template.thredded_workgroup.url_for params
        end
      end

      # Override the Kaminari::Helpers::Paginator methods as of kaminari v1.2.2 (fragile)
      def page_tag(page)
        @last = Thredded::Workgroup::Paginator::Page.new @template, **@options.merge(page: page)
      end

      # rubocop:disable Security/Eval
      # rubocop:disable Style/DocumentDynamicEvalDefinition
      %w[first_page prev_page next_page last_page gap].each do |tag|
        eval <<-DEF, nil, __FILE__, __LINE__ + 1
          def #{tag}_tag
            @last = Thredded::Workgroup::Paginator::#{tag.classify}.new @template, **@options
          end
        DEF
      end

      # Create the relevant classes with the URL overrides
      %w[page first_page prev_page next_page last_page gap].each do |tag|
        eval <<-DEF, nil, __FILE__, __LINE__ + 1
          class #{tag.classify} < ::Kaminari::Helpers:: #{tag.classify}
            include UrlFixer
          end
        DEF
      end
      # rubocop:enable Security/Eval
      # rubocop:enable Style/DocumentDynamicEvalDefinition
    end
  end
end
