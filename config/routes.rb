# config/routes.rb
Rails.application.routes.draw do
  resources :games, only: [:create, :show] do
    resources :rolls, only: :create
  end
end
