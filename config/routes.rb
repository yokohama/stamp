Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
    registrations: 'users/registrations'
  }

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }

  namespace :admins do
    root to: "dashboard#index"

    resources :votings
    resources :users
  end

  namespace :users do
    root to: "dashboard#index"

    resource :invitation_password, only: [:edit, :update]
    resources :submits, only: [:index, :show, :edit, :update]
  end

end
