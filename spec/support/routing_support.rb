# frozen_string_literal: true
module RoutingSupport
  extend RSpec::SharedContext

  def personalized_navigation_root_path
    Thredded::PersonalizedNavigation::Engine.routes.url_helpers.root_path
  end

  [:unread_nav_path, :following_nav_path, :all_topics_nav_path].each do |path_method|
    define_method path_method do
      Thredded::PersonalizedNavigation::Engine.routes.url_helpers.send(path_method)
    end
  end

  def messageboards_nav_path
    Thredded::Engine.routes.url_helpers.root_path
  end

  def thredded_messageboard_path(messageboard)
    Thredded::Engine.routes.url_helpers.messageboard_topics_path(messageboard)
  end

  def thredded_topic_path(topic)
    Thredded::Engine.routes.url_helpers.messageboard_topic_path(topic.messageboard, topic)
  end
end
RSpec.configure do |config|
  config.include RoutingSupport, type: :feature
end
