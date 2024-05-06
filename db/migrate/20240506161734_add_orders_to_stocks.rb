class AddOrdersToStocks < ActiveRecord::Migration[7.0]
  def change
    add_reference :stocks, :order, index: true
  end
end
