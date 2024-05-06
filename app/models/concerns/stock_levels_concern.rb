# frozen_string_literal: true

module StockLevelsConcern
  extend ActiveSupport::Concern

  class_methods do
    def stock_levels
      levels = []
      Stock.all.uniq.pluck(:warehouse_id).each do |warehouse_id|
        warehouse_code = Warehouse.find(warehouse_id).code
        warehouse_entry = (Hash[warehouse_code, []])
        Stock.where(warehouse_id:).each do |stock|
          warehouse_entry[warehouse_code].append({ 'product_code': Product.find(stock.product_id).code,
                                                   'total': stock.quantity,
                                                   'reserved': Order.pending(warehouse_id, stock.product_id) })
        end
        levels.append(warehouse_entry)
      end

      levels
    end
  end
end
