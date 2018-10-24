# frozen_string_literal: true

require "spec_helper"

module Thredded
  module Workgroup
    describe TopicsController, type: :controller do
      routes { Thredded::Workgroup::Engine.routes }

      let(:user) { create(:user) }
      let(:other_user) { create(:user) }
      let(:messageboard) { create(:messageboard) }
      let(:topic) { create(:topic, messageboard: messageboard, title: "hi") }
      let!(:the_post) { create(:post, postable: topic, content: "hi") }
      before do
        allow(controller).to receive_messages(
          topics: [topic],
          cannot?: false,
          the_current_user: user,
          messageboard: messageboard
        )
      end

      describe "POST kick" do
        let!(:user_topic_follow) { Thredded::UserTopicFollow.create_unless_exists(other_user.id, topic.id) }

        subject(:kick_it) do
          post :kick, params: { id: topic.id, user_id: other_user.id }
        end

        it "unfollows" do
          expect { kick_it }.to change { topic.reload.followers.reload.count }.by(-1)
        end

        context "json format" do
          subject(:kick_it) do
            post :kick, params: { id: topic.id, user_id: other_user.id, format: :json }
          end

          it "unfollows" do
            expect { kick_it }.to change { topic.reload.followers.reload.count }.by(-1)
          end
        end
      end
    end
  end
end
