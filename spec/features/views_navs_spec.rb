# frozen_string_literal: true
require "spec_helper"

describe "Views navs", type: :feature do
  let(:messageboard) { create(:messageboard, name: "Some message board") }
  let(:topic) { create(:topic, messageboard: messageboard) }
  let!(:post) { create(:post, postable: topic) }
  let(:user) { create(:user) }
  let(:log_in) do
    visit new_user_session_path
    fill_in "name", with: user
    click_button "Sign in"
  end
  before { log_in }

  context "unread" do
    let(:unread_topic) { create(:topic) }
    let(:unread_unfollowed_topic) { create(:topic) }
    let(:read_topic) { create(:topic) }

    before do
      unread_unfollowed_topic
      unread_topic.following_users << user
      read_topic.following_users << user
      create(:user_topic_read_state, postable: read_topic, read_at: read_topic.updated_at, user_id: user.id)
    end
    it "shows unread but not read topics" do
      visit unread_nav_path
      expect(page).to have_link_to(thredded_topic_path(unread_topic))
      expect(page).not_to have_link_to(thredded_topic_path(read_topic))
      expect(page).not_to have_link_to(thredded_topic_path(unread_unfollowed_topic))
    end
  end

  # context "messageboards" do
  #   it "can navigate to others" do
  #     visit messageboards_nav_path
  #     expect(page).to have_link_to(unread_nav_path)
  #   end
  # end
end
