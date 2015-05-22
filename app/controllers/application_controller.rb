class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate

  private

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['s3_username'] && password == ENV['s3_password']
    end
  end
end
