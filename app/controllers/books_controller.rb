# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    @books = Book.efficiency_list.recent(30)
    @rankings = Book.where(id: Ranking.order(rank: :asc).limit(10).select(:book_id)).includes(:author, :rakuten_book_info)
  end

  def show
    @book = Book.find_by(id: params[:id])
  end

  def search
    @books = Book.search(params[:title])
  end

  def ranking
    @rankings = Book.where(id: Ranking.order(rank: :asc).limit(10).select(:book_id)).includes(:author, :rakuten_book_info)
  end
end
