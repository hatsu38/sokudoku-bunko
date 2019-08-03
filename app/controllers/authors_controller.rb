# frozen_string_literal: true

class AuthorsController < ApplicationController
  def index
    @authors = Author.all.limit(30)
  end

  def show
    @author = Author.find_by!(name: params[:name])
    @rankings = Book.where(id: Ranking.order(rank: :asc).select(:book_id)).limit(10).includes(:author, :rakuten_book_info)
  end
end
