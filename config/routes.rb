Rails.application.routes.draw do
  # Custom RegistrationsController for user sign-up
  devise_for :users, skip: [:registrations]
  devise_scope :user do
    post '/users/add_new_user', to: 'registrations#create'
  end

  # Custom SessionsController for user sign-in
  devise_scope :user do
    post '/users/log_in', to: 'users/sessions#create'
    get '/users/current', to: 'users/sessions#current'
    delete '/users/log_out', to: 'users/sessions#destroy'
  end

  resources :users, only: %i[index] do
    resources :cars, only: %i[index show create destroy] do
      resources :reservations, only: %i[index show create destroy]
    end
    resources :reservations, only: %i[index show create destroy]
  end
end
