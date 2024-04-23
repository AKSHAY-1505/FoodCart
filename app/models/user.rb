class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  enum role: [:customer,:admin]

  has_one :admin, dependent: :destroy
  has_one :customer, dependent: :destroy

  accepts_nested_attributes_for :customer

end
