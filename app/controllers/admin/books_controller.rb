# frozen_string_literal: true

class Admin::BooksController < AdminController
  PER = 20
  def index
    @books = Book.includes(:author, :rakuten_book_info).page(params[:page]).per(PER).order(id: :desc)
  end

  def show
    @book = Book.find_by(id: params[:id])
  end

  def edit
    @book = Book.find_by(id: params[:id])
  end

  def update
    @book = Book.find_by(id: params[:id])
    if @book.update(book_params)
      flash[:success] = '更新しました'
      redirect_to admin_book_path(@book)
    else
      flash[:danger] = '更新に失敗しました'
      render 'edit'
    end
  end

  def search
    @authors = Author.search(params[:keyword])
    @books = Book.search(params[:keyword])
  end

  private

  def book_params
    params.require(:book).permit(:title, :txt_file, :published,
                                 rakuten_book_info_attributes: %i[id price affiliate_url small_image_url medium_image_url])
  end
end
