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

  before { log_in }

  scenario "can mark a post as unread" do
    visit thredded_topic_path(topic)
    post = topic.first_post
    within("article#post_#{post.id}") do
      click_on("Mark unread from here", visible: false)
    end
    expect(page.current_path).to eq thredded_workgroup.unread_nav_path
  end
end
