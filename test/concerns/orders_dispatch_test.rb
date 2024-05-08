# frozen_string_literal: true

require 'test_helper'

class OrdersDummy < ActiveRecord::Base
  self.table_name = 'orders'

  include OrdersConcern
end

class OrdersDispatchTest < ActiveSupport::TestCase
  test 'succesfully dipatches order' do
    OrdersDummy.dispatch '2'

    assert_equal Order.find('2').dispatched, true

    assert_equal Stock.where(order_id: 2).count, 0
  end

  test 'errors on dispatching dispatched order' do
    exception = assert_raises(Order::OrderDispatchError) { OrdersDummy.dispatch '1' }
    assert_equal(exception.message, 'Order 1 has already been dispatched')
  end
end
