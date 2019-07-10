# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    @books = Book.efficiency_list.recent(30)
  end

  def show
    @book = Book.find_by(id: params[:id])
    @sentence = IO.read("db/txt/#{@book.txt_file}")
  end

  def search
    @books = Book.search(params[:title])
  end
end
