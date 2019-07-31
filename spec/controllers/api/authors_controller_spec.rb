# frozen_string_literal: true

require 'rails_helper'

describe Api::AuthorsController, type: :controller do
  let!(:authors) { create_list(:author, 3) }

  describe 'GET index' do
    it 'works' do
      get :index, format: :json
      expect(response.status).to eq(200)
      expect(assigns(:authors).pluck(:id)).to match_array(Author.all.pluck(:id))
    end
  end

  describe 'get #show' do
    it 'work' do
      get :show, params: { name: authors.first.name }, format: :json
      expect(assigns(:author)).to eq(authors.first)
      expect(response.status).to eq(200)
    end
  end
end
