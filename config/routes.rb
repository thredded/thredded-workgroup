# frozen_string_literal: true
Thredded::PersonalizedNavigation::Engine.routes.draw do
  controller "navs" do
    get "unread", to: :unread, as: :unread_nav
  end

  mount Thredded::Engine => ""
end
