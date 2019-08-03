# frozen_string_literal: true

class Api::AuthorsController < ApplicationController
  PER = 20
  def index
    @authors = Author.page(params[:page]).per(PER)
  end

  def show
    @author = Author.find_by(name: params[:name])
    @books = @authors ? @author.books.page(params[:page]).per(PER).includes(:author, :rakuten_book_info) : nil
  end
end
