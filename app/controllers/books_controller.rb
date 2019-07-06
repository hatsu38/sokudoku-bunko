# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    @books = Book.all.limit(30)
  end

  def show
    @book = Book.find_by(id: params[:id])
  end
end
