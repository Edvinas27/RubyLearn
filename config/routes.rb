# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :books, only: [:index, :show, :create, :destroy]
      resources :authors, only: [:index, :show, :create, :destroy]
      post 'sign_in', to: 'sessions#create'
      post 'sign_up', to: 'registrations#create'
      resources :sessions, only: [:index, :show, :destroy]
      resource  :password, only: [:edit, :update]
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end
