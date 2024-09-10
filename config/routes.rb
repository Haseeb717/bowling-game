# config/routes.rb
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :games, only: [:create, :show] do
        resources :rolls, only: :create
      end
    end
  end
end
