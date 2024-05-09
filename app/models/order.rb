class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  belongs_to :address
  has_one :order_delivery_agent
  # before_create :address_present?

  enum status: %i[order_placed delivery_agent_assigned out_for_delivery delivered]

  after_create :create_order_items

  def assign_agent(agent)
    OrderDeliveryAgent.create(order: self, user: agent, assigned_at: Time.now)
    self.status = 'delivery_agent_assigned'
    save
  end

  def update_status(new_status)
    self.status = new_status
    self.is_active = false if status == 'delivered'
    self.order_delivery_agent.update(delivered_at: Time.now) if status == 'delivered'
    save
  end

  private

  def create_order_items
    Services::Order::OrderItemsCreator.new(self).call
  end

  # def address_present?
  # end
end
