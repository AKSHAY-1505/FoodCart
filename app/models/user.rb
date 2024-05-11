class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
  belongs_to :role
  has_many :orders, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :order_delivery_agents, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }

  def self.from_google(u)
    create_with(uid: u[:uid], provider: 'google', name: u[:info][:name],
                password: Devise.friendly_token[0, 20]).find_or_create_by!(email: u[:email])
  end
end
