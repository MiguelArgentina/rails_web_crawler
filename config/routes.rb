Rails.application.routes.draw do
  resources :epa_products do
    match '/scrape', to: 'epa_products#scrape', via: :post, on: :collection
  end

  root to: 'epa_products#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
