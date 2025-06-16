Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
  }

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }

  root to: 'users/dashboard#index'

  namespace :admins do
    root to: 'deliveries#index'
    resources :meals, only: %i[index new edit create update destroy]
    resources :meal_sets, only: %i[index new edit create update destroy]
    resources :deliveries, only: %i[index update]
  end

  namespace :users do
    root to: 'dashboard#index'
    resources :addresses, only: %i[index new edit create update destroy]
    resource :subscription, only: %i[show new edit create update] do
      resources :deliveries, only: %i[index show new edit create update], module: :subscriptions
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end
