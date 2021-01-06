Rails.application.routes.draw do
  root 'home#index'
  resources :my_threads do
    resources :posts
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
