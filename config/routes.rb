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
  post '/listeners/matches_query', to: 'listeners#matches_query'
  root to: 'listeners#index'
end
