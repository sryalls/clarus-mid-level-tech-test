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
                 [{ 'ABC123' => [{ product_code: 'ABC123', total: 10, reserved: 4 }] },
                  { 'XYZ789' => [{ product_code: 'DEF456', total: 8, reserved: 0 }] }]
  end
end
