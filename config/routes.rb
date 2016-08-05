# frozen_string_literal: true
Thredded::PersonalizedNavigation::Engine.routes.draw do
  controller "navs" do
    get "unread", action: :unread, as: :unread_nav
    get "following", action: :following, as: :following_nav
  end

  mount Thredded::Engine => ""
end
