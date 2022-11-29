# frozen_string_literal: true

Thredded::AllViewHooks.class_eval do
  include Thredded::Workgroup::ViewHooks
end
