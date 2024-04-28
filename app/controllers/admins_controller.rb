class AdminsController < ApplicationController
  before_action :authenticate_user

  def home
  end

  private

  def authenticate_user
    redirect_to root_path, alert: 'You are not authorised to access this page!' unless current_user&.admin?
  end
end
