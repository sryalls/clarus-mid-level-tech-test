# frozen_string_literal: true

require 'test_helper'

class StockLevelsDummy < ActiveRecord::Base
  self.table_name = 'stocks'

  include StockLevelsConcern
end

class StockIntakeTest < ActiveSupport::TestCase
  test 'add stock to warehouse' do
    warehouse = Warehouse.find_by(code: 'ABC123')
    product = Product.find_by(code: 'ABC123')

    StockLevelsDummy.intake(warehouse.id, product.id, 5)

    stock_count = Stock.where(warehouse_id: warehouse.id, product_id: product.id).count

    assert_equal stock_count, 11
  end

  test 'add new stock to warehouse' do
    warehouse = Warehouse.find_by(code: 'ABC123')
    product = Product.find_by(code: 'GHI789')

    StockLevelsDummy.intake(warehouse.id, product.id, 5)

    stock_count = Stock.where(warehouse_id: warehouse.id, product_id: product.id).count

    assert_equal stock_count, 5
  end
end
