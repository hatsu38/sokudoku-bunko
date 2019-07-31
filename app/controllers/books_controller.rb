# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    @books = Book.efficiency_list.recent(30)
    @rankings = Book.where(id: Ranking.order(rank: :asc).select(:book_id)).limit(10).includes(:author, :rakuten_book_info)
  end

  def show
    @book = Book.find_by(title: params[:title])
    @rankings = Book.where(id: Ranking.order(rank: :asc).select(:book_id)).limit(10).includes(:author, :rakuten_book_info)
  end

  def search
    @books = Book.search(params[:title])
  end

  def ranking
    @rankings = Book.where(id: Ranking.order(rank: :asc).select(:book_id)).limit(10).includes(:author, :rakuten_book_info)
  end
end
