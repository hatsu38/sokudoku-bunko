# frozen_string_literal: true

class Api::BooksController < ApplicationController
  require 'natto'
  PER = 20
  def index
    @books = Book.efficiency_list.page(params[:page]).per(PER).order(id: :desc)
  end

  def show
    @book = Book.find_by(id: params[:id])
    File.open("db/txt/#{@book.txt_file}", 'r') do |f|
      natto = Natto::MeCab.new
      @words = natto.enum_parse(f.read)
    end
    rescue StandardError => e
      logger.warn(e.inspect)
  end

  def search
    @books = Book.search(params[:title])
  end
end
