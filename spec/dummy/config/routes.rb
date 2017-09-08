# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "home#show"

  resources :user_sessions,
            only: %i(new create),
            controller: "sessions"
  delete "/session" => "sessions#destroy",
         as: :destroy_user_session

  resources :users, only: [:show], path: "u"

  mount RailsEmailPreview::Engine, at: "/emails"

  # IMPORTANT: Mandatory for Thredded::Workgroup dummy
  mount Thredded::Workgroup::Engine => "/thredded"
end
