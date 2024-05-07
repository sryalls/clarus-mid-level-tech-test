# frozen_string_literal: true

require 'test_helper'

class OrderCreatorTest < ActiveSupport::TestCase
  warehouse = Warehouse.find_by(code: 'ABC123')
  product = Product.find_by(code: 'ABC123')
  test 'correctly creates order and allocates stock' do
    order_id = OrderCreator.call(warehouse.id, product.id, 2)

    order = Order.find(order_id)

    assert_equal order.warehouse_id, warehouse.id
    assert_equal order.product_id, product.id
    assert_equal order.quantity, 2

    assert_equal Stock.where(warehouse_id: warehouse.id, product_id: product.id, reserved: true).count, 6
    assert_equal Stock.where(warehouse_id: warehouse.id, product_id: product.id, reserved: true, order_id:).count,
                 2
    assert_equal Stock.where(warehouse_id: warehouse.id, product_id: product.id, reserved: false).count, 0
  end

  test 'returns false when not enough stock available' do
    order_id = OrderCreator.call(warehouse.id, product.id, 3)

    assert_equal order_id, false
    assert_equal Stock.where(warehouse_id: warehouse.id, product_id: product.id, reserved: true).count, 4
    assert_equal Stock.where(warehouse_id: warehouse.id, product_id: product.id, reserved: false).count, 2
  end
end
