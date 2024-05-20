class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :foods, through: :order_items
  belongs_to :address
  has_one :order_delivery_agent

  validates :subtotal, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :delivery_charge, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :discount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true

  enum status: %i[order_placed delivery_agent_assigned out_for_delivery delivered]

  after_create :create_order_items
  after_create :send_order_placed_email

  scope :active, -> { where(is_active: true) }

  # to assign a delivery agent to an order
  def assign_agent(agent)
    OrderDeliveryAgent.create(order: self, user: agent, assigned_at: Time.now)
    update(status: 'delivery_agent_assigned')
  end

  # to update status and mark the order as inactive
  def update_status(new_status)
    order_delivery_agent.update(delivered_at: Time.now) if new_status == 'delivered'
    update(is_active: false) if new_status == 'delivered'
    update(status: new_status)
  end

  private

  # send order details email to user 
  def send_order_placed_email
    OrderMailer.new_order(self).deliver_later
  end

  # to create order items for each food in cart
  def create_order_items
    order_items = OrderItem.where(user: user, ordered: false)
    order_items.update_all(order_id: id, ordered: true)
  end
end
