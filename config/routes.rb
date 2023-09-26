# frozen_string_literal: true

Rails.application.routes.draw do
  # Root route
  root 'users#home'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Admin dashboard route
  get 'admin_dashboard', to: 'users#admin_dashboard', as: 'admin_dashboard'
  get 'user_dashboard', to: 'users#user_dashboard', as: 'user_dashboard'
  get 'admin_checkin', to: 'users#admin_checkin', as: 'admin_checkin'
  get 'user_checkin', to: 'users#user_checkin', as: 'user_checkin'
  post 'admin_checkin', to: 'users#admin_checkin'
  post 'user_checkin', to: 'users#checkin'
  post 'add_admin', to: 'users#add_admin', as: 'admin_add_admin'
  get '/users/home', to: 'users#home', as: 'users_home'
  get '/events/index', to: 'events#index', as: 'events_index'
  get '/events/new', to: 'events#new', as: 'events_new'

  # Users routes
  resources :users do
    collection do
      put :grant_admin
    end
    post 'add_admin', on: :collection
  end

  # Events routes
  resources :events, only: %i[index new create destroy]
end
