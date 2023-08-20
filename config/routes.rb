Rails.application.routes.draw do
  get 'private/test'
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }
  resources :users, only: %i[index create] do
    resources :cars, only: %i[index show create destroy] do
      resources :reservations, only: %i[index show create destroy]
    end
    resources :reservations, only: %i[index show create destroy]
  end
end
