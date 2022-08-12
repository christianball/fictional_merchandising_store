Rails.application.routes.draw do
  resources :items, only: [:index, :update]

  post '/items/total', to: 'items#total'
end
