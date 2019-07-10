# frozen_string_literal: true

class Api::BooksController < ApplicationController
  require 'natto'
  def index
    @books = Book.efficiency_list.recent(30)
  end

  def show
    @book = Book.find_by(id: params[:id])
    File.open("db/txt/#{@book.txt_file}", 'r') do |f|
      natto = Natto::MeCab.new
      @words = natto.enum_parse(f.read)
    end
  end

  def search
    @books = Book.search(params[:title])
  end
end
