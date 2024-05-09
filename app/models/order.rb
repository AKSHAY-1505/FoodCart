class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  belongs_to :address
  # before_create :address_present?

  enum status: %i[order_placed delivery_agent_assigned out_for_delivery delivered]

  after_create :create_order_items

  def assign_agent(agent)
    self.delivery_agent = agent
    self.status = 'delivery_agent_assigned'
    save
  end

  def update_status(new_status)
    self.status = new_status
    self.is_active = false if status == 'delivered'
    save
  end

  private

  def create_order_items
    Services::Order::OrderItemsCreator.new(self).call
  end

  # def address_present?
  # end
end
