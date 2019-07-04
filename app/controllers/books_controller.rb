class BooksController < ApplicationController
  require 'natto'

  def index
    @books = Book.all.limit(30).includes(:author)
  end

  def show
    @book = Book.find_by(id: params[:id])
  end
end
