Rails.application.routes.draw do
  root "categories#index"
  resources :categories,     only: [:index, :show]
  resources :discussions,    only: [:show]
  resources :search,         only: [:index]
  resources :users,          only: [:show]
  resources :badges,         only: [:show]
  get       'tagged/(:tag)', to: 'tags#show', as: 'tag'

  # backwards compatibility with vanilla URL scheme:
  get       'index.php',     to: 'redirect#redirect'

  # route anything else to a custom 404
  match     '*p',            to: "application#routing_error", via: :all
end
