class AdminsController < ApplicationController
  before_action :authenticate_admin

  def home
    @active_orders = Order.active.order(created_at: :desc).paginate(page: params[:page], per_page: 5)

    @agents = User.where(role_id: delivery_agent_role_id)
  end

  private

  def delivery_agent_role_id
    Role.find_by(name: 'Delivery Agent').id
  end
end
