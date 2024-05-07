# frozen_string_literal: true

class OrdersController < ApplicationController
  # PUT /stocks/:warehouse_id/:product_id/:quantity
  def create
    warehouse_id = params['warehouse_id']
    product_id = params['product_id']

    begin
      Warehouse.find(warehouse_id)
    rescue ActiveRecord::RecordNotFound
      return render json: { error: "warehouse #{warehouse_id} does not exist" }, status: 412
    end

    begin
      Product.find(product_id)
    rescue ActiveRecord::RecordNotFound
      return render json: { error: "product #{product_id} does not exist" }, status: 412
    end
    begin
      quantity = Integer(params['quantity'])
    rescue ArgumentError
      return render json: { error: 'Quantity must be an integer' }, status: 400
    end

    job_id = PlaceOrderJob.perform_later(warehouse_id, product_id, quantity)

    render json: { job_id: }
  end
end
