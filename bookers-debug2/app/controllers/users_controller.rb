class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :index, :show]
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def follows
    user = User.find(params[:id])
    @users = user.follows
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  def index
    @users = User.all
  end

  def edit
    @user = current_user
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'You have updated user successfully.'
    else
      @book = Book.new
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless @user == current_user
  end
end
