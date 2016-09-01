# frozen_string_literal: true
# rubocop:disable Style/Semicolon
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

  let(:unread_followed_topic) { create(:topic).tap { |topic| topic.followers << user } }
  let(:unread_unfollowed_topic) { create(:topic) }
  let(:read_followed_topic) do
    create(:topic).tap do |topic|
      topic.followers << user
      create(:user_topic_read_state, postable: topic, read_at: topic.updated_at, user_id: user.id)
    end
  end

  it "can still view a topic" do
    create(:post, postable: unread_followed_topic)
    visit thredded_topic_path(unread_followed_topic)
  end

  context "unread" do
    before { unread_unfollowed_topic; unread_followed_topic; read_followed_topic }

    it "shows unread but not read topics" do
      visit unread_nav_path
      expect(page).to have_link_to(thredded_topic_path(unread_followed_topic))
      expect(page).not_to have_link_to(thredded_topic_path(read_followed_topic))
      expect(page).not_to have_link_to(thredded_topic_path(unread_unfollowed_topic))
    end

    it "shows last post" do
      create(:post, content: "Something new in sandwiches", postable: unread_followed_topic)
      visit unread_nav_path
      expect(page).to have_content("Something new in sandwiches")
    end

    include ActionView::RecordIdentifier
    it "shows messageboard name" do
      visit unread_nav_path
      within "##{dom_id(unread_followed_topic)}" do
        expect(page).to have_content(unread_followed_topic.messageboard.name)
      end
    end
    it "links to messageboard" do
      visit unread_nav_path
      within "##{dom_id(unread_followed_topic)} .thredded--messageboard-name" do
        e = find("a")
        expect(e["href"]).to eq(thredded_messageboard_path(unread_followed_topic.messageboard))
      end
    end

    context "when Thredded.show_topic_followers" do
      around do |ex|
        was = Thredded.show_topic_followers
        begin
          Thredded.show_topic_followers = true
          ex.call
        ensure
          Thredded.show_topic_followers = was
        end
      end
      it "shows followers" do
        user = create(:user, name: "jeremiah")
        unread_followed_topic.followers << user
        visit unread_nav_path
        within "##{dom_id(unread_followed_topic)}" do
          expect(page).to have_content("@jeremiah")
        end
      end
    end
  end

  context "following" do
    before { unread_unfollowed_topic; unread_followed_topic; read_followed_topic }
    it "shows followed but not read topics" do
      visit following_nav_path
      expect(page).to have_link_to(thredded_topic_path(unread_followed_topic))
      expect(page).to have_link_to(thredded_topic_path(read_followed_topic))
      expect(page).not_to have_link_to(thredded_topic_path(unread_unfollowed_topic))
    end
  end

  context "all_topics" do
    before { unread_unfollowed_topic; unread_followed_topic; read_followed_topic }
    it "shows followed but not read topics" do
      visit all_topics_nav_path
      expect(page).to have_link_to(thredded_topic_path(unread_followed_topic))
      expect(page).to have_link_to(thredded_topic_path(read_followed_topic))
      expect(page).to have_link_to(thredded_topic_path(unread_unfollowed_topic))
    end
    it "is linked from messageboards" do
      visit messageboards_nav_path
      expect(page).to have_link_to(all_topics_nav_path)
    end
  end

  # context "messageboards" do
  #   it "can navigate to others" do
  #     visit messageboards_nav_path
  #     expect(page).to have_link_to(unread_nav_path)
  #   end
  # end
end
# rubocop:enable Style/Semicolon
