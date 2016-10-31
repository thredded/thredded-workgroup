# frozen_string_literal: true
require_dependency File.expand_path("../../app/controllers/thredded/posts_controller", Thredded::Engine.called_from)

module Thredded
  class PostsController < Thredded::ApplicationController
    def create
      post = parent_topic.posts.build(post_params)
      authorize_creating post
      post.save!
      flash[:notice] = "Successfully replied to #{view_context.link_to(parent_topic.title, messageboard_topic_path(parent_topic.messageboard, parent_topic, anchor: "post_#{post.id}"))}".html_safe
      if params[:post_referer].present?
        redirect_to params[:post_referer]
      else
        redirect_to unread_nav_path
      end
    end
  end
end
