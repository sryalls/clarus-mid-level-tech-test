# frozen_string_literal: true

module StockLevelsConcern
  extend ActiveSupport::Concern

  class_methods do
    def stock_levels
      levels = {}
      Stock.select(:warehouse_id, :product_id).distinct.each do |stock|
        warehouse_code = Warehouse.find(stock.warehouse_id).code
        levels[warehouse_code] = [] unless levels.keys.include? warehouse_code

        levels[warehouse_code].append(specific_stock_levels(stock.warehouse_id, stock.product_id))
      end

      levels
    end

    def specific_stock_levels(warehouse_id, product_id)
      reserved = Stock.where(reserved: true, product_id:, warehouse_id:).count
      unreserved = Stock.where(reserved: false, product_id:, warehouse_id:).count

      { 'product_code': Product.find(product_id).code,
        'total': unreserved + reserved,
        'unreserved': unreserved,
        'reserved': reserved }
    end

    def intake(warehouse_id, product_id, quantity)
      quantity.times do
        Stock.create!(warehouse_id:, product_id:)
      end
    end
  end
end
