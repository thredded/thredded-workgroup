# frozen_string_literal: true

# frozen_string_literal: true # frozen_string_literal: true

module Thredded
  module Workgroup
    class TopicsController < Thredded::Workgroup::ApplicationController
      before_action :thredded_require_login!

      def kick
        if (user_topic_follow = UserTopicFollow.where(topic_id: params[:id], user_id: params[:user_id]).first)
          user_topic_follow.destroy
        end
        render plain: "Ok"
      end
    end
  end
end
