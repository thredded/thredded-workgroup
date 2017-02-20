# frozen_string_literal: true
module Thredded

  private

  def after_mark_as_unread
    if post.private_topic_post?
      redirect_to private_topics_path
    else
      redirect_to thredded_personalized_navigation.unread_nav_path(messageboard)
    end
  end
end
