Rails.application.routes.draw do
  # Custom RegistrationsController for user sign-up
  devise_for :users, skip: [:registrations]
  devise_scope :user do
    post '/users', to: 'registrations#create'
  end

  # Custom SessionsController for user sign-in
  devise_scope :user do
    post '/users/sign_in', to: 'users/sessions#create'
    delete '/users/sign_out', to: 'users/sessions#destroy'
  end

  resources :users, only: %i[index create] do
    resources :cars, only: %i[index show create destroy] do
      resources :reservations, only: %i[index show create destroy]
    end
    resources :reservations, only: %i[index show create destroy]
  end
end
