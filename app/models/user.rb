class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  enum role: %i[customer admin delivery_agent]

  has_one :admin, dependent: :destroy
  has_one :customer, dependent: :destroy
  has_one :delivery_agent, dependent: :destroy
  after_create :create_customer

  def self.from_google(u)
    create_with(uid: u[:uid], provider: 'google', name: u[:info][:name],
                password: Devise.friendly_token[0, 20]).find_or_create_by!(email: u[:email])
  end

  private

  def create_customer
    return unless role == 'customer'

    Customer.create(user: self)
  end
end
