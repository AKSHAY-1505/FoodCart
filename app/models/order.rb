class Order < ApplicationRecord
  ORDER_ITEMS_CREATOR_CLASS = Services::OrderService::OrderItemsCreator

  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :foods, through: :order_items
  belongs_to :address
  has_one :order_delivery_agent

  enum status: %i[order_placed delivery_agent_assigned out_for_delivery delivered]

  after_create :create_order_items

  def assign_agent(agent)
    OrderDeliveryAgent.create(order: self, user: agent, assigned_at: Time.now)
    update(status: 'delivery_agent_assigned')
  end

  def update_status(new_status)
    order_delivery_agent.update(delivered_at: Time.now) if new_status == 'delivered'
    update(is_active: false) if new_status == 'delivered'
    update(status: new_status)
  end

  private

  def create_order_items
    ORDER_ITEMS_CREATOR_CLASS.new(self).create_order_items
  end
end
