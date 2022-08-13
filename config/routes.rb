# frozen_string_literal: true

Rails.application.routes.draw do
  resources :items, only: %i[index update]

  post '/items/total', to: 'items#total'
end
