Rails.application.routes.draw do
  devise_for :users

  root 'posts#index'

  get 'home/about_me', as: 'about_me'
  resources :posts
end
