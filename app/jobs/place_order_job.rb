# frozen_string_literal: true

class PlaceOrderJob < ApplicationJob
  def perform(warehouse_id, product_id, quantity)
    OrderCreator.call(warehouse_id, product_id, quantity)
  end
end
