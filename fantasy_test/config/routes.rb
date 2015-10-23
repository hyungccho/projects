Rails.application.routes.draw do
  root to: 'sessions#new'

  resources :teams

  get '/players/:player_id', to: 'players#show', as: 'player'

  resources :users do
    resources :leagues, only: [:new, :create]
  end

  resource :session, only: [:new, :create, :destroy]
  resources :leagues, except: [:new, :create] do
    member do
      get 'player'
      get 'available_players'
    end

    resources :drafts, only: [:new, :create]
    resources :user_memberships, only: [:create]
  end

  resources :league_memberships, only: [:create]
  resources :user_memberships, except: [:create]
end
