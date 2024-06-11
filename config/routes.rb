Rails.application.routes.draw do
  root "categories#index"
  resources :categories,     only: [:index, :show]
  resources :discussions,    only: [:show]
  resources :search,         only: [:index]
  resources :users,          only: [:show]
  resources :badges,         only: [:show]
  get       'tagged/(:tag)', to: 'tags#show', as: 'tag'

  get       'index.php',     to: 'redirect#redirect'
end
