# frozen_string_literal: true

module PendingOrdersConcern
  extend ActiveSupport::Concern

  class_methods do
    def pending(warehouse_id, product_id)
      Order.where(warehouse_id:, product_id:, dispatched: false).sum(:quantity)
    end
  end
end
