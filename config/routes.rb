Rails.application.routes.draw do
  resources :social_watchers
  resources :listeners
  resources :suggestions

  get 'callbacks/messenger', to: 'callbacks#messenger'
  root to: 'listeners#index'
end
