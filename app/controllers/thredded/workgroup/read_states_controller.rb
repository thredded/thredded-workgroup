# frozen_string_literal: true

module Thredded
  module Workgroup
    class ReadStatesController < ::Thredded::Workgroup::ApplicationController
      before_action :thredded_require_login!

      def mark_all_topics_read
        ::Thredded::Workgroup::MarkAllTopicsReadJob.perform_later(thredded_current_user) if thredded_signed_in?
        redirect_to request.referer, flash: { notice: "Marking all topics as read (will take a few seconds)" }
      end
    end
  end
end
