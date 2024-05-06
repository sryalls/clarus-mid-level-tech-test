# frozen_string_literal: true

module PendingOrdersConcern
  extend ActiveSupport::Concern

  class_methods do
    def pending(warehouse_id, product_id)
      Stock.where(warehouse_id:, product_id:, reserved: true).count
    end
  end
end
