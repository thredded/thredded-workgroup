# frozen_string_literal: true
Thredded::PersonalizedNavigation::Engine.routes.draw do
  controller "navs" do
    get "unread", action: :unread, as: :unread_nav
    get "following", action: :following, as: :following_nav
    get "all_topics", action: :all_topics, as: :all_topics_nav
    get "awaiting", action: :awaiting, as: :awaiting_nav
  end

  mount Thredded::Engine => "/"
end
