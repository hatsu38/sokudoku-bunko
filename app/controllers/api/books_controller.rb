# frozen_string_literal: true

class Api::BooksController < ApplicationController
  require 'natto'
  def index
    @books = Book.order(id: 'DESC')
  end

  def show
    @book = Book.find_by(id: params[:id])
    natto = Natto::MeCab.new
    @words = natto.enum_parse(@book.sentence)
  end
end
