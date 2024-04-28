class DeliveryAgentsController < ApplicationController
  def create
    @agent = DeliveryAgent.new(delivery_agent_params)
    if @agent.save
      redirect_to admin_home_path, notice: 'Delivery Agent Created Successfully!'
    else
      redirect_to admin_home_path, alert: 'Error! Unable to Create Delivery Agent'
    end
  end

  def new
    @agent = DeliveryAgent.new
    @agent.build_user
  end

  private

  def delivery_agent_params
    params.require(:delivery_agent).permit(user_attributes: %i[name email password password_confirmation])
  end
end
