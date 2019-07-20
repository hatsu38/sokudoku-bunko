# frozen_string_literal: true

require 'rails_helper'

describe AuthorsController, type: :controller do
  let!(:authors) { create_list(:author, 3) }

  describe 'GET index' do
    it 'works' do
      get :index
      expect(response.status).to eq(200)
      expect(assigns(:authors).pluck(:id)).to match_array(Author.all.pluck(:id))
    end
  end

  describe 'get #show' do
    it 'work' do
      get :show, params: { id: authors.first.id }
      expect(assigns(:author)).to eq(authors.first)
      expect(assigns(:rankings).pluck(:id)).to match_array(Book.all.pluck(:id))
      expect(response.status).to eq(200)
      expect(response).to render_template :show
    end
  end
end
