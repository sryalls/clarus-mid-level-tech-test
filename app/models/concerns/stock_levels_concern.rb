# frozen_string_literal: true

module StockLevelsConcern
  extend ActiveSupport::Concern

  class_methods do
    def stock_levels
      levels = {}
      Stock.select(:warehouse_id, :product_id).distinct.each do |stock|
        warehouse_code = Warehouse.find(stock.warehouse_id).code
        levels[warehouse_code] = [] unless levels.keys.include? warehouse_code

        reserved = Stock.where(reserved: true, product_id: stock.product_id, warehouse_id: stock.warehouse_id).count
        unreserved = Stock.where(reserved: false, product_id: stock.product_id, warehouse_id: stock.warehouse_id).count
        levels[warehouse_code].append({ 'product_code': Product.find(stock.product_id).code,
                                        'total': unreserved + reserved,
                                        'reserved': reserved })
      end

      levels
    end

    def intake(warehouse_id, product_id, quantity)
      quantity.times do
        Stock.create!(warehouse_id:, product_id:)
      end
    end
  end
end
