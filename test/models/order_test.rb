# frozen_string_literal: true

require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  warehouse = Warehouse.find_by(code: 'ABC123')
  product = Product.find_by(code: 'ABC123')
  test 'creates order with despatch default false' do
    order = Order.create(warehouse:, product:, quantity: 4)
    assert_equal order.dispatched, false
  end

  test 'order requires warehouse' do
    order = Order.new(product:, quantity: 4)
    assert_not order.save
  end

  test 'order requires product' do
    order = Order.new(warehouse:, quantity: 4)
    assert_not order.save
  end

  test 'order requires quantity' do
    order = Order.new(warehouse:, product:)
    assert_not order.save
  end

  test 'quantity must be greater than zero' do
    order = Order.create(warehouse:, product:, quantity: 0)
    assert_not order.save
  end

  test 'quantity must be positive' do
    order = Order.create(warehouse:, product:, quantity: -2)
    assert_not order.save
  end
end
