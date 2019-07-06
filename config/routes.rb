# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'books#index'
  resources :books, only: %i[index show]
  resources :authors, only: %i[index show]
  namespace :api, format: 'json' do
    resources :books, only: %i[index show]
  end
end
