Rails.application.routes.draw do
  resources :stocks, only: [:index, :show]

put '/stocks/:warehouse_id/:product_id/:quantity', to: 'stocks#intake'
  resources :warehouses
  resources :products
end
