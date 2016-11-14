Rails.application.routes.draw do
  devise_for :users

  root 'home#about_me'

  resources :posts
end
