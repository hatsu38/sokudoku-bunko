# frozen_string_literal: true

require 'rails_helper'

describe Admin::AuthorsController, type: :controller do
  let!(:authors) { create_list(:author, 3) }
  context 'login' do
    let!(:admin) { create(:user) }
    before(:each) { login_admin(admin) }

    describe 'GET index' do
      it 'works' do
        get :index
        expect(response.status).to eq(200)
        expect(assigns(:authors).pluck(:id)).to match_array(Author.all.pluck(:id))
        expect(response).to render_template :index
      end
    end

    describe 'get #show' do
      it 'work' do
        get :show, params: { id: authors.first.id }
        expect(assigns(:author)).to eq(authors.first)
        expect(response.status).to eq(200)
        expect(response).to render_template :show
      end
    end

    describe 'get #edit' do
      it 'work' do
        get :edit, params: { id: authors.first.id }
        expect(assigns(:author)).to eq(authors.first)
        expect(response.status).to eq(200)
        expect(response).to render_template :edit
      end
    end

    describe 'POST update' do
      let(:author) { authors.first }
      context 'success' do
        let(:update_params) do
          {
            name: '新著者',
            birthday: author.birthday,
          }
        end
        it 'works' do
          post :update, params: { id: author.id, author: update_params }
          aggregate_failures do
            expect(response.status).to eq(302)
            expect(response).to redirect_to(admin_author_path(author))
            expect(assigns(:author).id).to eq(author.id)
            updated = Author.find_by(id: author.id)
            expect(updated.name).to eq('新著者')
            expect(flash[:success]).to be_present
            expect(flash[:danger]).to eq nil
          end
        end
      end

      context 'validation error' do
        let(:valid_update_params) do
          {
            name: '',
            birthday: author.birthday,
          }
        end
        it 'not updated' do
          post :update, params: { id: authors.first.id, author: valid_update_params }
          aggregate_failures do
            expect(response.status).to eq(200)
            expect(assigns(:author)).to eq(author)
            expect(flash[:danger]).to be_present
            expect(flash[:success]).to eq nil
            expect(response).to render_template :edit
          end
        end
      end
    end
  end
  context 'not login' do
    shared_examples '302-redirect_to' do
      it 'work' do
        expect(response.status).to eq(302)
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'GET index' do
      before { get :index }
      it_behaves_like '302-redirect_to'
    end

    describe 'get #show' do
      before { get :show, params: { id: authors.first.id } }
      it_behaves_like '302-redirect_to'
    end

    describe 'get #edit' do
      before { get :edit, params: { id: authors.first.id } }
      it_behaves_like '302-redirect_to'
    end
  end
end
