# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Main app pages", type: :system do
  let(:log_in) do
    visit main_app.new_user_session_path
    fill_in "name", with: user.name
    click_button "Sign in"
  end

  let(:user) { create(:user) }
  before do
    create_list(:user_topic_follow, 2, user: user)
    log_in
  end
  it "can see all_unread_followed_topics_count" do
    within(".all-unread-followed-topics-count") do
      expect(page).to have_content(2)
    end
  end
end
