Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[index create destroy] do
    resources :cars, only: %i[index show create destroy] do
      resources :reservations, only: %i[index show create destroy]
    end
    resources :reservations, only: %i[index show create destroy]
  end
  resources :cars, only: %i[index]
end
