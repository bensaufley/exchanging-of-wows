class AdminController < ApplicationController
  http_basic_authenticate_with name: 'test', password: 'test', unless: :action_is_public?

  private
  def action_is_public?
    false
  end
end
