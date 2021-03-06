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
      get :show, params: { name: authors.first.name }
      expect(assigns(:author)).to eq(authors.first)
      expect(assigns(:rankings).pluck(:id)).to match_array(Book.all.pluck(:id))
      expect(response.status).to eq(200)
      expect(response).to render_template :show
    end

    context 'error_404' do
      it 'work' do
        get :show, params: { name: "#{authors.first.name}_hoge" }
        expect(response.status).to eq(404)
        expect(response).to render_template('errors/404')
      end
    end
  end
end
