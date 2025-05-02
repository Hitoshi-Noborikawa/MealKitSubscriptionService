Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
  }

  namespace :admins do
    root to: 'dashboard#index'
    resources :meal_sets
  end
end
