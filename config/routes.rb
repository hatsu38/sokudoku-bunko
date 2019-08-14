# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'books#index'
  resources :books, only: %i[index show], param: :title
  get :search, to: 'books#search'
  get :ranking, to: 'books#ranking'
  resources :authors, only: %i[index show], param: :name

  namespace :api, format: 'json' do
    resources :books, only: %i[index show], param: :title
    get :search, to: 'books#search'
    get :ranking, to: 'books#ranking'
    resources :authors, only: %i[index show], param: :name
  end

  devise_for :users

  namespace :admin do
    get :search, to: 'books#search'
    get '/', to: 'books#index'
    resources :books, only: %i[index show edit update]
    post '/books/:id/rakuten_create', to: 'books#rakuten_create', as: 'rakuten_create'
    get :search, to: 'books#search'
    resources :authors, only: %i[index show edit update]
  end

  get '*path', to: 'application#error_404'
end
