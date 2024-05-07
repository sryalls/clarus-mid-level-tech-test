# frozen_string_literal: true

class OrderCreator
  def self.call(*args, &block)
    new(*args, &block).call
  end

  def initialize(warehouse_id, product_id, quantity)
    @warehouse_id = warehouse_id
    @product_id = product_id
    @quantity = quantity
  end

  def call
    return false unless verify_stock

    create_order
    @order.id
  end

  private

  def verify_stock
    inventory = Stock.specific_stock_levels(@warehouse_id, @product_id)
    inventory[:unreserved] >= @quantity
  end

  def create_order
    # @todo - wrap this in a transaction and active job to avoid race conditins
    @order = Order.create(warehouse_id: @warehouse_id, product_id: @product_id, quantity: @quantity)
    allocate_stocks
  end

  def allocate_stocks
    @quantity.times do
      stock = Stock.find_by(warehouse_id: @warehouse_id, product_id: @product_id, reserved: false)
      stock.update(reserved: true, order_id: @order.id)
    end
  end
end