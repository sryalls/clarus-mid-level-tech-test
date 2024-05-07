# frozen_string_literal: true

class StockIntakeJob < ApplicationJob
  def perform(warehouse_id, product_id, quantity)
    Stock.intake(warehouse_id, product_id, quantity)
  end
end
