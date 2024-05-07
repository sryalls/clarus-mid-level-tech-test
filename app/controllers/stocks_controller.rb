# frozen_string_literal: true

class StocksController < ApplicationController
  before_action :set_stock, only: %i[show update destroy]

  # GET /stocks
  def index
    @stocks = Stock.stock_levels

    render json: @stocks
  end

  # GET /stocks/1
  def show
    render json: @stock
  end

  # PUT /stocks/:warehouse_id/:product_id/:quantity
  def intake
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
    job_id = StockIntakeJob.perform_later(warehouse_id, product_id, quantity)
    render json: { job_id: }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_stock
    @stock = Stock.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def stock_params
    params.require(:stock).permit(:quantity, :warehouse_id, :product_id)
  end
end
