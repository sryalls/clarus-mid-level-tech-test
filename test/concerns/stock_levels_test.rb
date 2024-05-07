# frozen_string_literal: true

require 'test_helper'

class StockLevelsDummy < ActiveRecord::Base
  self.table_name = 'stocks'

  include StockLevelsConcern
end

class StockLevelsTest < ActiveSupport::TestCase
  test 'correctly gets the remaining stock levles' do
    inventory = StockLevelsDummy.stock_levels

    assert_equal inventory,
                 {
                   'ABC123' => [{ product_code: 'DEF456', total: 1, unreserved: 1, reserved: 0 },
                                { product_code: 'ABC123', total: 6, unreserved: 2,
                                  reserved: 4 }],
                   'XYZ789' => [{ product_code: 'DEF456', total: 1, unreserved: 1, reserved: 0 }]
                 }
  end
end
