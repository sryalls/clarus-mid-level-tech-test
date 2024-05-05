# frozen_string_literal: true

# require 'pending_orders_concern'
require 'test_helper'

class PendingOrderDummy < ActiveRecord::Base
  self.table_name = 'orders'

  include PendingOrdersConcern
end

class PendingOrdersTest < ActiveSupport::TestCase
  warehouse = Warehouse.find_by(code: 'ABC123')
  product = Product.find_by(code: 'ABC123')
  test 'gets pending orders by warehouse and product' do
    reserved = PendingOrderDummy.pending(warehouse.id, product.id)

    assert_equal reserved, 4
  end
end
