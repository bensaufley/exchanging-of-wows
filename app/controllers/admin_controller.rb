class AdminController < ApplicationController
  http_basic_authenticate_with name: ENV['BACKEND_USERNAME'], password: ENV['BACKEND_PASSWORD'], unless: :action_is_public?

  private
  def action_is_public?
    false
  end
end
