Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :social_watchers
  resources :listeners
  resources :suggestions
  root to: 'listeners#index'
end
