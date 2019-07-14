# frozen_string_literal: true

class Api::AuthorsController < ApplicationController
  PER = 20
  def index
    @authors = Author.page(params[:page]).per(PER)
    render json: { 'authors': @authors }
  end

  def show
    @author = Author.find_by(id: params[:id])
    @books = @author.books.page(params[:page]).per(PER)
  end
end
