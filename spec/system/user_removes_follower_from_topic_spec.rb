# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Logged in user" do
  let(:messageboard) { create(:messageboard) }
  let(:topic) { create(:topic, with_posts: 1, messageboard: messageboard) }
  let(:user) { create(:user) }
  let(:follower) { create(:user, name: "SomeoneElse") }

  let(:log_in) do
    visit main_app.new_user_session_path
    fill_in "name", with: user.name
    click_button "Sign in"
  end

  before do
    topic.followers << follower
    log_in
  end

  it "can remove a follower from a topic", js: true do
    visit thredded_topic_path(topic)
    expect(page).to have_content "@SomeoneElse"
    within ".thredded--form.thredded--post-form" do
      within ".user-#{follower.id}" do
        find("button").click
      end
      expect(page).not_to have_content "@SomeoneElse"
    end
  end
end
