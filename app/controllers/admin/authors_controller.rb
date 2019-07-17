# frozen_string_literal: true

class Admin::AuthorsController < AdminController
  PER = 20
  def index
    @authors = Author.page(params[:page]).per(PER).order(id: :desc)
  end

  def show
    @author = Author.find_by(id: params[:id])
  end

  def edit
    @author = Author.find_by(id: params[:id])
  end

  def update
    @author = Author.find_by(id: params[:id])
    if @author.update(author_params)
      redirect_to admin_author_path(@author)
    else
      render 'edit'
    end
  end

  private

  def author_params
    params.require(:author).permit(:name, :birthday)
  end
end
