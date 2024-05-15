require 'minitest/autorun'
require 'test/unit'
require '/Users/akbalamurugan/Desktop/Final Project/Demo/FoodCart/test/test_helper'
require_relative '/Users/akbalamurugan/Desktop/Final Project/Demo/FoodCart/lib/services/cart_item_service/cart_item_creator'

describe Services::CartItemService::CartItemCreator do
  subject { Services::CartItemService::CartItemCreator }

  describe 'TEST Services::CartItemService::CartItemCreator' do
    let(:user_struct) do
      OpenStruct.new({ id: 1, name: 'Aksahy' })
    end

    let(:quantity_nil_params) do
      { food_quantity: 5, food_price: 100, food_quantity_str: '5' }
    end

    let(:item_in_cart_mock) do
      mock = Minitest::Mock.new
      mock.expect(:quantity, nil, [])
      mock.expect(:quantity=, quantity_nil_params[:food_quantity], [quantity_nil_params[:food_quantity]])
      mock.expect(:quantity, 5, [])
      mock.expect(:subtotal=, 500, [100 * 5])

      mock
    end

    let(:food_instance_mock) do
      mock = Minitest::Mock.new
      mock.expect(:quantity, 10, [])
      mock.expect(:update, true, [{ quantity: 5 }])
      mock.expect(:price, 100, [])
      mock
    end

    let(:food_class_mock) do
      mock = Minitest::Mock.new
      mock.expect(:find, food_instance_mock, [1])
      mock
    end

    let(:order_item_class_mock) do
      mock = Minitest::Mock.new
      mock.expect(:find_or_initialize_by, item_in_cart_mock,
                  [{ user: user_struct, food: food_instance_mock, ordered: false }])
      mock
    end

    # it 'test initialize' do
    #   test_obj = subject.new(user_struct, 1, '5', food_class_mock, order_item_class_mock)
    #   assert_instance_of Services::CartItemService::CartItemCreator, test_obj
    # end

    # it 'tests the decrease_food_stock feature' do
    #   test_obj = subject.new(user_struct, 1, '5', food_class_mock, order_item_class_mock)
    #   result = test_obj.decrease_food_stock
    #   assert result, true
    # end

    it 'tests the create_cart_item feature' do
      test_obj = subject.new(user_struct, 1, quantity_nil_params[:food_quantity], food_class_mock,
                             order_item_class_mock)
      result = test_obj.create_cart_item
    end
  end
end
