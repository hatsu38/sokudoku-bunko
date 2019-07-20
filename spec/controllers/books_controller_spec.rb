# frozen_string_literal: true

require 'rails_helper'

describe BooksController, type: :controller do
  let!(:books) { create_list(:book, 2) }

  describe 'GET index' do
    it 'works' do
      get :index
      expect(response.status).to eq(200)
      expect(assigns(:books).pluck(:id)).to match_array(Book.all.pluck(:id))
      expect(assigns(:rankings).pluck(:id)).to match_array(Book.all.pluck(:id))
    end
  end

  describe 'get #show' do
    it 'work' do
      get :show, params: { id: books.first.id }
      expect(assigns(:book)).to eq(books.first)
      expect(assigns(:rankings).pluck(:id)).to match_array(Book.all.pluck(:id))
      expect(response.status).to eq(200)
      expect(response).to render_template :show
    end
  end

  describe 'get #search' do
    let!(:book) { create(:book, title: '羅生門') }
    it 'work' do
      get :search, params: { title: '生門' }
      expect(assigns(:books).first.title).to eq(book.title)
      expect(response.status).to eq(200)
      expect(response).to render_template :search
    end
  end

  describe 'get #ranking' do
    it 'work' do
      get :ranking
      expect(assigns(:rankings).pluck(:id)).to match_array(Book.all.pluck(:id))
      expect(response.status).to eq(200)
      expect(response).to render_template :ranking
    end
  end
end
