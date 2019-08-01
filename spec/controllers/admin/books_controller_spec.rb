# frozen_string_literal: true

require 'rails_helper'

describe Admin::BooksController, type: :controller do
  let!(:books) { create_list(:book, 2) }
  context 'login' do
    let!(:admin) { create(:user) }
    before(:each) { login_admin(admin) }
    describe 'GET index' do
      it 'works' do
        get :index
        expect(response.status).to eq(200)
        expect(assigns(:books).pluck(:id)).to match_array(Book.all.pluck(:id))
        expect(response).to render_template :index
      end
    end

    describe 'get #show' do
      it 'work' do
        get :show, params: { id: books.first.id }
        expect(assigns(:book)).to eq(books.first)
        expect(response.status).to eq(200)
        expect(response).to render_template :show
      end
    end

    describe 'get #edit' do
      it 'work' do
        get :edit, params: { id: books.first.id }
        expect(assigns(:book)).to eq(books.first)
        expect(response.status).to eq(200)
        expect(response).to render_template :edit
      end
    end

    describe 'POST update' do
      let(:book) { books.first }
      context 'success' do
        let(:update_params) do
          {
            title: 'テスト完了',
            txt_file: book.txt_file,
            published: book.published,
            rakuten_book_info_attributes: {
              id: book.rakuten_book_info.id,
              price: 1999,
              affiliate_url: book.rakuten_book_info.affiliate_url,
              small_image_url: book.rakuten_book_info.small_image_url,
              medium_image_url: book.rakuten_book_info.medium_image_url,
            },
          }
        end
        it 'works' do
          post :update, params: { id: book.id, book: update_params }
          aggregate_failures do
            expect(response.status).to eq(302)
            expect(response).to redirect_to(admin_book_path(book))
            expect(assigns(:book).id).to eq(book.id)
            updated = Book.find_by!(id: book.id)
            expect(updated.title).to eq('テスト完了')
            expect(flash[:success]).to be_present
            expect(flash[:danger]).to eq nil
            expect(updated.rakuten_book_info.price).to eq(1999)
          end
        end
      end

      context 'validation error' do
        let(:valid_update_params) do
          {
            title: '',
            txt_file: book.txt_file,
            published: book.published,
            rakuten_book_info_attributes: {
              id: book.rakuten_book_info.id,
              price: 1999,
              affiliate_url: book.rakuten_book_info.affiliate_url,
              small_image_url: book.rakuten_book_info.small_image_url,
              medium_image_url: book.rakuten_book_info.medium_image_url,
            },
          }
        end
        it 'not updated' do
          post :update, params: { id: books.first.id, book: valid_update_params }
          aggregate_failures do
            expect(response.status).to eq(200)
            expect(assigns(:book)).to eq(book)
            expect(flash[:danger]).to be_present
            expect(flash[:success]).to eq nil
            expect(response).to render_template :edit
          end
        end
      end
    end

    describe 'GET searh' do
      let!(:book) { create(:book, title: 'Result') }
      let!(:author) { create(:author, name: 'Result') }
      it 'works' do
        get :search, params: { keyword: 'Resu' }
        expect(response.status).to eq(200)
        expect(assigns(:books).first.title).to eq('Result')
        expect(assigns(:authors).first.name).to eq('Result')
        expect(assigns(:books).count).to eq(1)
        expect(assigns(:authors).count).to eq(1)
        expect(response).to render_template :search
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
      before { get :show, params: { id: books.first.id } }
      it_behaves_like '302-redirect_to'
    end

    describe 'get #edit' do
      before { get :edit, params: { id: books.first.id } }
      it_behaves_like '302-redirect_to'
    end

    describe 'GET searh' do
      let!(:book) { create(:book, title: 'Result') }
      let!(:author) { create(:author, name: 'Result') }
      before { get :search, params: { keyword: 'Resu' } }
      it_behaves_like '302-redirect_to'
    end
  end
end
