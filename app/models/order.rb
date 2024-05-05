class Order < ApplicationRecord
  belongs_to :warehouse
  belongs_to :product

  validates :warehouse, presence: true
  validates :product, presence: true
  validates :quantity, presence: true
  validates :quantity, numericality: {greater_than: 0}

  # validates quantity is gt 0
end
