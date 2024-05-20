class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  helper_method :delivery_address

  def delivery_address(address)
    [address.house_number, address.street_name, address.locality, address.city].join(',')
  end
end
