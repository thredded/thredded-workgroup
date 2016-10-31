# frozen_string_literal: true
require "spec_helper"

describe "Getting referred back", type: :feature do
  let(:messageboard) { create(:messageboard, name: "Some message board") }
  let(:user) { create(:user) }
  let(:log_in) do
    visit main_app.new_user_session_path
    fill_in "name", with: user
    click_button "Sign in"
  end
  before { log_in }

  let!(:topic) { create(:topic).tap { |topic| topic.followers << user } }
  let!(:post) { create(:post, postable: topic) }

  describe "from unread" do
    it "works" do
      visit unread_nav_path
      click_on topic.title
      fill_in "Content", with: "reply"
      click_on "Submit Reply"
      expect(current_path).to eq unread_nav_path
      expect(page).to have_css".thredded--flash-message"
    end
  end

  describe "from following" do
    it "works" do
      visit following_nav_path
      click_on topic.title
      fill_in "Content", with: "reply"
      click_on "Submit Reply"
      expect(current_path).to eq following_nav_path
      expect(page).to have_css".thredded--flash-message"
    end
  end

  describe "from no where" do
    it "redirects back to unread" do
      visit thredded_topic_path(topic)
      fill_in "Content", with: "reply"
      click_on "Submit Reply"
      expect(current_path).to eq unread_nav_path
    end
  end
end
