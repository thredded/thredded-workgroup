# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Signing in" do
  specify "Visitor with existing account signs in" do
    create(:user, name: "joe", email: "joe@example.com")
    visit main_app.new_user_session_path
    fill_in "name", with: "joe"
    click_button "Sign in"

    expect(page).to have_content("joe")
    expect(page).to have_content("Sign out")
  end
end
