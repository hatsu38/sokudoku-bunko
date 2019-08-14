# frozen_string_literal: true

class BooksController < ApplicationController
  impressionist actions: [:show]
  before_action :set_ranking, only: %i[index show ranking]
  def index
    @books = Book.viewable.efficiency_list.recent(30)
  end

  def show
    @book = Book.find_by!(title: params[:title])
    impressionist(@book, nil, unique: [:session_hash])
  end

  def search
    @books = Book.viewable.search(params[:title])
  end

  def ranking
  end

  private

  def set_ranking
    @rankings = Book.viewable.where(id: Ranking.order(rank: :asc).select(:book_id)).limit(12).includes(:author, :rakuten_book_info)
  end
end
