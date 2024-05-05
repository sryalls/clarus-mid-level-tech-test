class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.decimal :quantity, null: false
      t.boolean :dispatched, null: false, default: false
      t.belongs_to :warehouse, null: false, foreign_key: true
      t.belongs_to :product, null: false, foreign_key: true
      t.timestamps
    end
  end
end
