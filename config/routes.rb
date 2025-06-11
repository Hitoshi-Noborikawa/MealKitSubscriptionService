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
    # TODO: root書くんだったら resourceも書きたい
    root to: 'dashboard#index'
    resources :meals, only: %i[index new edit create update destroy]
    resources :meal_sets, only: %i[index new edit create update destroy]
  end

  namespace :users do
    # TODO: root書くんだったら resourceも書きたい
    root to: 'dashboard#index'
    resources :addresses, only: %i[index new edit create update destroy]
    resource :subscription, only: %i[show new edit create update] do
      resources :deliveries, only: %i[index show new edit create update], module: :subscriptions
    end
    resource :account, only: %i[edit update]
  end
end
