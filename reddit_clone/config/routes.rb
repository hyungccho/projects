Rails.application.routes.draw do
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :subs do
    resources :posts, only: [:new, :create]
  end

  resources :posts, except: [:index, :new] do
    resources :comments, only: [:new]
  end

  resources :comments, only: [:create, :show]

  root to: 'sessions#new'
end
