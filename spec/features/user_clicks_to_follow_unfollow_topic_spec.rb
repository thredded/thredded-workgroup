# frozen_string_literal: true
require "spec_helper"

describe "Clicking to follow / unfollow topics", type: :feature  do
  let(:messageboard) { create(:messageboard, name: "Some message board") }
  let(:user) { create(:user) }
  let(:log_in) do
    visit new_user_session_path
    fill_in "name", with: user
    click_button "Sign in"
  end
  before { log_in }

  context "with an unfollowed topic" do
    let!(:topic) { create(:topic, messageboard: messageboard) }
    let!(:post) { create(:post, postable: topic) }

    specify "you can click to follow", js: true do
      visit all_topics_nav_path
      within "#topic_#{topic.id}.thredded--topic-notfollowing" do
        find(".thredded--topic-follow-icon svg").click
      end
      TransactionalCapybara::AjaxHelpers.wait_for_ajax(page)
      expect(page).to have_css("#topic_#{topic.id}.thredded--topic-following")
      expect(topic.reload.followers).to include(user)
    end
  end

  context "with a followed topic" do
    let!(:post) { create(:post, postable: topic) }
    let!(:topic) do
      create(:topic, messageboard: messageboard).tap do |topic|
        topic.followers << user
      end
    end

    specify "you can click to unfollow", js: true do
      visit all_topics_nav_path
      within "#topic_#{topic.id}.thredded--topic-following" do
        find(".thredded--topic-follow-icon svg").click
      end
      TransactionalCapybara::AjaxHelpers.wait_for_ajax(page)
      expect(page).to have_css("#topic_#{topic.id}.thredded--topic-notfollowing")
      expect(topic.reload.followers).to_not include(user)
    end
  end
end
