Rails.application.routes.draw do
  root 'welcome#home'

  resources :users
  resources :articles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
