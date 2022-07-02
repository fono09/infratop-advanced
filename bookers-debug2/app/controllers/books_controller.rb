class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:show, :index, :edit]
  before_action :ensure_correct_user, only: [:edit]

  ORDER_BY_CREATED_AT = 'created_at'
  ORDER_BY_RATING = 'rating'
  ORDER_BY_PERMIT = [ORDER_BY_CREATED_AT, ORDER_BY_RATING]

  def show
    @book = Book.find(params[:id])
  end

  def index
    if ORDER_BY_PERMIT.include?(params["order_by"])
      @books = Book.all.order(params["order_by"].to_sym => :desc)
    else
      @books = Book.all.order(created_at: :desc)
    end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :rating)
  end

  def ensure_correct_user
    @user = Book.find(params[:id]).user
    unless @user == current_user
      redirect_to books_path
    end
  end
end
