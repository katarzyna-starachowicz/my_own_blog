Rails.application.routes.draw do
  devise_for :users

  root 'posts#index'

  get 'home/about_me', as: 'about_me'

  resources :posts do
    resources :comments, only: [:new, :create]
  end

  resources :comments do
    resources :comments, only: [:new, :create]
  end
end
