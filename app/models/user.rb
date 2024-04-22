class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:customer,:admin]

  has_one :admin, dependent: :destroy
  has_one :customer, dependent: :destroy
  
  after_create :create_admin_or_customer

  private

  def create_admin_or_customer
    self.admin? ? Admin.create(user_id: self.id) : Customer.create(user_id: self.id)
  end
end
