# frozen_string_literal: true

Rails.application.routes.draw do
  resources :stocks, only: %i[index]

  put '/stocks/:warehouse_id/:product_id/:quantity', to: 'stocks#intake'

  put '/orders/:warehouse_id/:product_id/:quantity', to: 'orders#create'
end
