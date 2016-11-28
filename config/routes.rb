Rails.application.routes.draw do
  devise_for :users

  root 'posts#index'

  get 'home/about_me', as: 'about_me'

  resources :posts, except: [:show, :index], module: :admin do
    resources :comments, only: :destroy
  end

  resources :posts, only: [:show, :index] do
    resources :comments, only: :create
  end

  resources :comments do
    resources :comments, only: :create
  end
end
