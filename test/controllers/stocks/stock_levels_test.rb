# frozen_string_literal: true

require 'test_helper'

class StockLevelsTest < ActionDispatch::IntegrationTest
  test 'successfully gets the stock levels' do
    get stocks_path

    assert_equal 200, status
    assert_equal body, [{ 'ABC123' => [{ product_code: 'ABC123', total: '10.0', reserved: '4.0' }] },
                        { 'XYZ789' => [{ product_code: 'DEF456', total: '8.0', reserved: '0.0' }] }].to_json
  end
end
