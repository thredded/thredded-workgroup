# frozen_string_literal: true
def personalized_navigation_root_path
  Thredded::PersonalizedNavigation::Engine.routes.url_helpers.root_path
end

def unread_nav_path
  Thredded::PersonalizedNavigation::Engine.routes.url_helpers.unread_nav_path
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
