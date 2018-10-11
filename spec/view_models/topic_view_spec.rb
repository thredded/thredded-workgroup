# frozen_string_literal: true

require "spec_helper"

module Thredded
  describe TopicView do
    let(:user) { create(:user) }
    let(:topic) { create(:topic, locked: true) }

    subject { TopicView.from_user(topic, create(:user)) }
    describe "path" do
      context "with a last_post" do
        let(:post) { create(:post, postable: topic) }
        before { allow(topic).to receive(:last_post).and_return(post) }
        it "includes anchor to last post" do
          expect(subject.path).to end_with("#post_#{post.id}")
        end
      end

      context "without a last_post (should never happen but still)" do
        it "still works" do
          expect(subject.path).to eq("/thredded/#{topic.messageboard.slug}/#{topic.slug}")
        end
      end
    end
  end
end
