# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :warehouse
  belongs_to :product
  has_many :stocks

  validates :warehouse, presence: true
  validates :product, presence: true
  validates :quantity, presence: true
  validates :quantity, numericality: { greater_than: 0 }

  include OrdersConcern
end
