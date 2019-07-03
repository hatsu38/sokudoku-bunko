class BooksController < ApplicationController
  require 'natto'

  def index
    @books = Book.all.limit(30)
  end

  def show
    @book = Book.find_by(id: params[:id])
    # natto = Natto::MeCab.new
    # @words = natto.enum_parse(@book.sentence)
  end
end