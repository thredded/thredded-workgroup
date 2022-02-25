# frozen_string_literal: true

require_dependency "errors"

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SetLocale
  include StoreLocationFullpath
  helper_method :the_current_user

  rescue_from ::Errors::UserNotFound do |exception|
    @message = exception.message
    render template: "shared/not_found", status: :not_found
  end

  # IMPORTANT: Mandatory for Thredded::Workgroup dummy (a spec depends on this)
  include Thredded::Workgroup::AllUnreadFollowedTopics

  protected

  def the_current_user
    return unless session[:user_id]
    @the_current_user ||= Thredded.user_class.find_by(id: session[:user_id]).tap do |user|
      # If the database has been recreated, user_id may be invalid.
      session.delete(:user_id) if user.nil?
    end
  end
end
