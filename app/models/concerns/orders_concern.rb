# frozen_string_literal: true

module OrdersConcern
  extend ActiveSupport::Concern

  class OrderDispatchError < StandardError; end

  class_methods do
    def dispatch(order_id)
      ActiveRecord::Base.transaction do
        order = Order.find(order_id)

        raise OrderDispatchError, "Order #{order_id} has already been dispatched" if order.dispatched == true

        order.update(dispatched: true)

        Stock.where(order_id:).destroy_all
      end
    end
  end
end
