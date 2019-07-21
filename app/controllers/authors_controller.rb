# frozen_string_literal: true

class AuthorsController < ApplicationController
  def index
    @authors = Author.all.limit(30)
  end

  def show
    @author = Author.find_by(id: params[:id])
    @rankings = Book.where(id: Ranking.order(rank: :asc).limit(10).select(:book_id)).includes(:author, :rakuten_book_info)
  end
end
