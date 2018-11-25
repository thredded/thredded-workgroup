# frozen_string_literal: true

require_dependency File.expand_path("../../app/view_hooks/thredded/all_view_hooks", Thredded::Engine.called_from)

module Thredded
  class AllViewHooks
    prepend ::Thredded::Workgroup::ViewHooks
  end
end
