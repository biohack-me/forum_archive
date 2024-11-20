Rails.application.routes.draw do
  root "categories#index"
  resources :categories,       only: [:index, :show]
  resources :discussions,      only: [:show]
  resources :search,           only: [:index]
  resources :users,            only: [:show] do
    get     'discussions',     to: 'users#discussions', as: 'discussions'
    get     'comments',        to: 'users#comments',    as: 'comments'
  end
  resources :badges,           only: [:show]
  get       'tagged/(:tag)',   to: 'tags#show', as: 'tag'

  # backwards compatibility with vanilla URL scheme:
  get       'index.php',       to: 'redirect#redirect'

  # route anything else to a custom 404
  match     '*p',              to: "application#routing_error", via: :get
  get       'bad_route/(:id)', to: "application#bad_format_routing_error"
end
