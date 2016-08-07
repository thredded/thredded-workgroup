# frozen_string_literal: true
module Thredded
  module PersonalizedNavigation
    class NavsController < Thredded::PersonalizedNavigation::ApplicationController
      before_action :thredded_require_login!, except: :root

      def unread
        @topics = gather_topics(Thredded::Topic.unread_followed_by(current_user))
      end

      def following
        @topics = gather_topics(Thredded::Topic.followed_by(current_user))
      end

      protected

      def gather_topics(scope)
        Thredded::TopicsPageView.new(
          thredded_current_user,
          scope
            .order_recently_updated_first
            .includes(:categories, :last_user, :user, :last_post)
            .page(current_page)
        )
      end

      def current_page
        (params[:page] || 1).to_i
      end

    end
  end
end
