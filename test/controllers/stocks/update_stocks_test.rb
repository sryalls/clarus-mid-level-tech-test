# frozen_string_literal: true

require 'test_helper'

class UpdateStocksTest < ActionDispatch::IntegrationTest
  test 'Successfully update stock' do
    warehouse = Warehouse.find_by(code: 'ABC123')
    product = Product.find_by(code: 'ABC123')

    put "/stocks/#{warehouse.id}/#{product.id}/5"

    assert_equal 200, status

    stock_count = Stock.where(warehouse_id: warehouse.id, product_id: product.id).count

    assert_equal stock_count, 11
  end

  test 'Successfully update new stock in warehouse' do
    warehouse = Warehouse.find_by(code: 'ABC123')
    product = Product.find_by(code: 'GHI789')

    put "/stocks/#{warehouse.id}/#{product.id}/5"

    assert_equal 200, status

    stock_count = Stock.where(warehouse_id: warehouse.id, product_id: product.id).count

    assert_equal stock_count, 5
  end

  test 'gracefully return for not found warehouse' do
    warehouse_id = '000000001'
    product = Product.find_by(code: 'ABC123')

    put "/stocks/#{warehouse_id}/#{product.id}/5"

    assert_equal 412, status
    assert_equal 'warehouse 000000001 does not exist', JSON.parse(body)['error']
  end

  test 'gracefully return for not found product' do
    product_id = '000000001'
    warehouse = Warehouse.find_by(code: 'ABC123')

    put "/stocks/#{warehouse.id}/#{product_id}/5"

    assert_equal 412, status
    assert_equal 'product 000000001 does not exist', JSON.parse(body)['error']
  end

  test 'gracefully return for non integer quantity' do
    warehouse = Warehouse.find_by(code: 'ABC123')
    product = Product.find_by(code: 'ABC123')

    put "/stocks/#{warehouse.id}/#{product.id}/five"

    assert_equal 400, status
    assert_equal 'Quantity must be an integer', JSON.parse(body)['error']
  end

end
