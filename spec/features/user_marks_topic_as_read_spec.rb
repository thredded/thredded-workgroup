# frozen_string_literal: true

require "spec_helper"

feature "Logged in user" do
  let(:messageboard) { create(:messageboard) }
  let(:topic) { create(:topic, with_posts: 1, messageboard: messageboard) }
  let(:user) { create(:user) }

  let(:log_in) do
    visit main_app.new_user_session_path
    fill_in "name", with: user.name
    click_button "Sign in"
  end

  before do
    Thredded::UserTopicReadState.touch!(user.id, topic.posts.last)
    log_in
  end

  scenario "can mark a post as read", js: true do
    visit all_topics_nav_path
    expect(page).to have_css("article#topic_#{topic.id}.thredded--topic-read")
    expect(page).not_to have_css("article#topic_#{topic.id}.thredded--topic-unread")
    within("article#topic_#{topic.id}") do
      find("[title='Mark as read']").trigger("click")
    end
    expect(page).not_to have_css("article#topic_#{topic.id}.thredded--topic-read")
    expect(page).to have_css("article#topic_#{topic.id}.thredded--topic-unread")
  end

  scenario "can mark all topics as read" do
    visit all_topics_nav_path
    expect(Thredded::Workgroup::MarkAllTopicsReadJob).to receive(:perform_later)
    click_on "Mark all topics as read"
  end
end
