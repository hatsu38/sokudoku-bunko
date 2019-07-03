Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'books#index'
  resources :books
  namespace :api, format: 'json' do
    resources :books
  end
end