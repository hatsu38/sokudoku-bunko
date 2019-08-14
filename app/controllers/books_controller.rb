# frozen_string_literal: true

class BooksController < ApplicationController
  impressionist actions: [:show]
  before_action :set_ranking, only: %i[index show]
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
    @rankings = Book.viewable.joins(:ranking).includes(:author, :rakuten_book_info, :ranking).order('rank')
  end

  private

  def set_ranking
    @rankings = Book.viewable.joins(:ranking).includes(:author, :rakuten_book_info, :ranking).order('rank').limit(15)
  end
end
