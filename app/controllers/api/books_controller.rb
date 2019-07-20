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
      sentence = f.read
      natto = Natto::MeCab.new
      page = params[:page].to_i
      pre_sentence = 800 * (page - 1)
      sentence.slice!(0..pre_sentence-1) if pre_sentence > 0
      @words = natto.enum_parse(sentence.truncate(800, omission: ''))
    end
  rescue StandardError => e
    logger.warn(e.inspect)
  end

  def search
    @books = Book.search(params[:title]).page(params[:page]).per(PER).order(id: :desc)
  end

  def ranking
    @books = Book.where(id: Ranking.page(params[:page]).per(PER).select(:book_id).order(rank: :asc)).includes(:author, :rakuten_book_info)
  end
end
