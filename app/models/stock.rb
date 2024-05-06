# frozen_string_literal: true

class Stock < ApplicationRecord
  belongs_to :warehouse
  belongs_to :product
  belongs_to :order, optional: true

  include StockLevelsConcern
end
