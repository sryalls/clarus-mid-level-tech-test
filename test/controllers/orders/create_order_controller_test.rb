# frozen_string_literal: true

require 'test_helper'

class CreateOrderControllerTest < ActionDispatch::IntegrationTest
  test 'successfully place order' do
    warehouse = Warehouse.find_by(code: 'ABC123')
    product = Product.find_by(code: 'ABC123')

    put "/orders/#{warehouse.id}/#{product.id}/2"

    assert_equal 200, status

  end

  test 'order too many items' do
    warehouse = Warehouse.find_by(code: 'ABC123')
    product = Product.find_by(code: 'ABC123')

    put "/orders/#{warehouse.id}/#{product.id}/3"

    assert_equal 202, status
    assert_equal 'The ordered product has fewer items in storage than has been ordered. Order not placed.', JSON.parse(body)['error']

  end

  test 'non numeric quantity' do
    warehouse = Warehouse.find_by(code: 'ABC123')
    product = Product.find_by(code: 'ABC123')

    put "/orders/#{warehouse.id}/#{product.id}/five"

    assert_equal 400, status
    assert_equal 'Quantity must be an integer', JSON.parse(body)['error']
  end

  test 'gracefully return for not found warehouse' do
    warehouse_id = '000000001'
    product = Product.find_by(code: 'ABC123')

    put "/orders/#{warehouse_id}/#{product.id}/5"

    assert_equal 412, status
    assert_equal 'warehouse 000000001 does not exist', JSON.parse(body)['error']
  end

  test 'gracefully return for not found product' do
    product_id = '000000001'
    warehouse = Warehouse.find_by(code: 'ABC123')

    put "/orders/#{warehouse.id}/#{product_id}/5"

    assert_equal 412, status
    assert_equal 'product 000000001 does not exist', JSON.parse(body)['error']
  end

end