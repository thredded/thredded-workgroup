# frozen_string_literal: true

Thredded::PostsController.class_eval do
  prepend ::Thredded::Workgroup::PostsControllerWhichRedirects
end
