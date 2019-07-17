# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'books#index'
  resources :books, only: %i[index show]
  get :search, to: 'books#search'
  get :ranking, to: 'books#ranking'
  resources :authors, only: %i[index show]

  namespace :api, format: 'json' do
    resources :books, only: %i[index show]
    get :search, to: 'books#search'
    get :ranking, to: 'books#ranking'
    resources :authors, only: %i[index show]
  end

  namespace :admin do
    get '/', to: 'books#index'
    resources :books
    get :search, to: 'books#search'
    resources :authors
  end
end
