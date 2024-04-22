class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: [:customer,:admin]
  after_create :create_admin_or_customer

  private

  def create_admin_or_customer
    if self.admin?
      Admin.create(user_id: self.id)
    else
      Customer.create(user_id: self.id)
    end
  end
end
