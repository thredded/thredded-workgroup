# frozen_string_literal: true
module RoutingSupport
  extend RSpec::SharedContext
  include Rails.application.routes.mounted_helpers
  include Thredded::Workgroup::Engine.routes.url_helpers
  # include Thredded::Workgroup::Engine.routes.url_helpers.root_path

  # [:unread_nav_path, :following_nav_path, :all_topics_nav_path, :awaiting_nav_path].each do |path_method|
  #   define_method path_method do
  #     Thredded::Workgroup::Engine.routes.url_helpers.send(path_method)
  #   end
  # end

  def messageboards_nav_path
    thredded.root_path
  end

  def thredded_messageboard_path(messageboard)
    thredded.messageboard_topics_path(messageboard)
  end

  def thredded_topic_path(topic)
    anchor = "post_#{topic.last_post.id}" if topic.last_post
    thredded.messageboard_topic_path(topic.messageboard, topic, anchor: anchor)
  end
end

RSpec.configure do |config|
  config.include RoutingSupport, type: :feature
end
