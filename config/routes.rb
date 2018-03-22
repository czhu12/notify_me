Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  mount Facebook::Messenger::Server, at: 'bot'
  resources :social_watchers
  resources :listeners
  resources :suggestions
  resources :charges

  get 'callbacks/messenger', to: 'callbacks#messenger'
  post 'callbacks/messenger', to: 'callbacks#messenger'
  root to: 'listeners#index'
end
