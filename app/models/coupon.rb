class Coupon < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :discount, :min_amount, presence: true
  validates :discount, :min_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :from_date, :to_date, presence: true
  validate :valid_date_range

  after_create :send_coupon_notification_emails

  private

  # to send notification emails to all users when coupon is created
  def send_coupon_notification_emails
    User.find_each(batch_size: 100) do |user|
      CouponMailer.new_coupon(self, user).deliver_later
    end
  end

  # custom validation to ensure to_date is greater than from_date
  def valid_date_range
    return if from_date.nil? || to_date.nil?

    errors.add('To Date must be greater than From Date') if to_date < from_date
  end
end
