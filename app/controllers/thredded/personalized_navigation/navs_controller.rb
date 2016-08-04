# frozen_string_literal: true
module Thredded
  module PersonalizedNavigation
    class NavsController < Thredded::PersonalizedNavigation::ApplicationController
      before_action :thredded_require_login!, except: :root

      def unread
        @topics = Thredded::TopicsPageView.new(
          thredded_current_user,
          Thredded::Topic.unread_followed_by(current_user)
            .order_recently_updated_first
            .includes(:categories, :last_user, :user)
            .page(current_page)
        )
      end

      protected

      def current_page
        (params[:page] || 1).to_i
      end
    end
  end
end
