# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    @books = Book.all.limit(30).includes(:author)
  end

  def show
    @book = Book.find_by(id: params[:id])
    @sentence = IO.read("db/txt/#{@book.txt_file}")
  end
end
