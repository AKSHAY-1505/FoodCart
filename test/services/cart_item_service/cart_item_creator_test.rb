require 'test_helper'
require 'minitest/autorun'
require 'services/cart_item_service/cart_item_creator'

class CartItemCreatorTest < Minitest::Test
  def setup
    @cart_creator_class = Services::CartItemService::CartItemCreator
    @user = user_mock
    @food = food_mock
    @order_item = order_item_mock
  end

  def test_creates_a_new_cart_item
    Food.stub(:find, @food) do
      OrderItem.stub(:find_or_initialize_by, @order_item) do
        @order_item.expect(:quantity, nil)
        @order_item.expect(:quantity=, nil)
        @order_item.expect(:subtotal=, nil)
        @food.expect(:quantity, 10)
        @food.expect(:update, true, [quantity: 5])

        subject = @cart_creator_class.new(@user, 1, 5)
        cart_item = subject.create_cart_item

        assert_equal 5, cart_item.quantity
        assert_equal 500, cart_item.subtotal
      end
    end
  end

  #   def test_updates_existing_cart_item
  #     Food.stub(:find, @food) do
  #       OrderItem.stub(:find_or_initialize_by, @order_item) do
  #         @order_item.expect(:quantity, 3)
  #         @order_item.expect(:quantity=, nil, [8])
  #         @order_item.expect(:subtotal=, nil, [800])
  #         @food.expect(:quantity, 10)
  #         @food.expect(:update, true, [quantity: 2])

  #         subject = @cart_creator_class.new(@user, 1, 5)
  #         cart_item = subject.create_cart_item

  #         assert_equal 8, cart_item.quantity
  #         assert_equal 800, cart_item.subtotal
  #       end
  #     end
  #   end

  private

  def user_mock
    mock = Minitest::Mock.new
    mock.expect(:id, 1)
    mock
  end

  def food_mock
    mock = Minitest::Mock.new
    mock.expect(:id, 1)
    mock.expect(:name, 'Food')
    mock.expect(:price, 100)
    mock.expect(:price, 100)
    mock
  end

  def order_item_mock
    mock = Minitest::Mock.new
    mock.expect(:user, @user)
    mock.expect(:food, @food)
    mock.expect(:ordered, false)
    mock.expect(:quantity, nil)
    mock.expect(:quantity=, nil, [5])
    mock.expect(:quantity, 0, [])
    mock.expect(:subtotal=, nil, [500]) # Expect subtotal= to be called with 500
    mock
  end
end
