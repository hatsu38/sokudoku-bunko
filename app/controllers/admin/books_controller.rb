# frozen_string_literal: true

class Admin::BooksController < ApplicationController
  PER = 10
  def index
    @books = Book.includes(:author, :rakuten_book_info).page(params[:page]).per(PER).order(id: :desc)
  end

  def search
    @books = Book.search(params[:title])
  end

  def edit
    @book = Book.find_by(id: params[:id])
  end

  def update
    @book = Book.fb1qind(params[:id])
    # binding.pry
    if @book.update(book_params)
      # updateが完了したら一覧ページへリダイレクト
      redirect_to admin_books_path
    else
      # updateを失敗すると編集ページへ
      render 'edit'
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :txt_file, :published,
      rakuten_book_info_attributes: [:id, :price, :affiliate_url, :small_image_url, :medium_image_url])
  end
end
