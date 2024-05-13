module RolesHelper
  ADMIN_ROLE = Role.find_by(name: 'Admin')
  DELIVERY_AGENT_ROLE = Role.find_by(name: 'Delivery Agent')
  CUSTOMER_ROLE = Role.find_by(name: 'Customer')
end
