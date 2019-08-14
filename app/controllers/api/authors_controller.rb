# frozen_string_literal: true

class Api::AuthorsController < ApplicationController
  PER = 10
  def index
    @authors = Author.joins(:books).includes(:books).page(params[:page]).per(PER).order(books_count: :desc)
  end

  def show
    @author = Author.find_by(name: params[:name])
    @books = @author ? @author.books.page(params[:page]).per(PER).includes(:author, :rakuten_book_info).order('rakuten_book_infos.medium_image_url desc') : nil
  end
end
