Rails.application.routes.draw do
  resources :games, only: [:index, :show, :create], defaults: { format: :json }
  resources :guesses, only: :create, defaults: { format: :json }, path: '/games/:id'
end
