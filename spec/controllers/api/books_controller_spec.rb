# frozen_string_literal: true

require 'rails_helper'

describe Api::BooksController, type: :controller do
  let!(:books) { create_list(:book, 3) }

  describe 'GET index' do
    it 'works' do
      get :index, format: :json
      expect(response.status).to eq(200)
      expect(assigns(:books).pluck(:id)).to match_array(Book.all.pluck(:id))
    end
  end

  describe 'get #show' do
    it 'work' do
      get :show, params: { id: books.first.id }, format: :json
      expect(assigns(:book)).to eq(books.first)
      expect(response.status).to eq(200)
    end
  end

  describe 'get #search' do
    let!(:book) { create(:book, title: '羅生門') }
    it 'work' do
      get :search, params: { title: '生門' }, format: :json
      expect(assigns(:books).first.title).to eq(book.title)
      expect(response.status).to eq(200)
    end
  end
end
