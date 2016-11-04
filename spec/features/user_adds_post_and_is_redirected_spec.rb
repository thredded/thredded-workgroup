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

  if Rails::VERSION::MAJOR < 5
    around do |example|
      TestAfterCommit.with_commits(true) do
        example.run
      end
    end
  end

  before do
    log_in
  end

  let(:topic) { create(:topic).tap { |topic| topic.followers << user } }
  let!(:post) { create(:post, postable: topic) }

  def topic_is_read
    readstate = Thredded::UserTopicReadState.find_by(user_id: user.id, postable_id: topic.id)
    readstate && readstate.read?
  end

  describe "from unread" do
    it "works" do
      travel 1.hour do
        visit unread_nav_path
        click_on topic.title
        fill_in "Content", with: "reply"
        click_on "Submit Reply"
        expect(current_path).to eq unread_nav_path
        expect(page).to have_css ".thredded--flash-message"
        expect(topic_is_read).to be_truthy
      end
    end
  end

  describe "from following" do
    it "works" do
      visit following_nav_path
      click_on topic.title
      fill_in "Content", with: "reply"
      click_on "Submit Reply"
      expect(current_path).to eq following_nav_path
      expect(page).to have_css ".thredded--flash-message"
      expect(topic_is_read).to be_truthy
    end
  end

  describe "from no where" do
    it "redirects back to unread" do
      visit thredded_topic_path(topic)
      fill_in "Content", with: "reply"
      click_on "Submit Reply"
      expect(current_path).to eq unread_nav_path
      expect(topic_is_read).to be_truthy
    end
  end
end