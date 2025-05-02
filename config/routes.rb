Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
  }

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }

  root to: 'users/dashboard#index'

  namespace :admins do
    root to: 'dashboard#index'
    resources :meal_sets
  end

  namespace :users do
    root to: 'dashboard#index'
    resource  :subscription, only: %i[new create edit update]
    resources :deliveries, only: %i[index show edit update]
    resource :account, only: %i[edit update]
  end
end
