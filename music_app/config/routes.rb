Rails.application.routes.draw do
  resources :users, only: [:new, :show, :create, :update, :destroy] do
    member do
      get 'activate'
    end
  end
  resource :session, only: [:new, :create, :destroy]

  resources :bands do
    resources :albums, only: [:new]
  end

  resources :albums, except: [:new, :index] do
    resources :tracks, only: [:new]
  end

  resources :tracks, except: [:new, :index] do
    resources :notes, only: [:new]
  end

  resources :notes, except: [:new]

  root to: redirect('session/new')
end
