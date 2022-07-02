class BookCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    params = book_comment_params.merge(user_id: current_user.id)
    book_comment = BookComment.new(params)
    book_comment.save
    @book = book_comment.book
  end

  def destroy
    book_comment = BookComment.find(params[:id])
    @book = book_comment.book
    book_comment.destroy
  end

  private 

  def book_comment_params
    params.require(:book_comment).permit(:book_id, :body)
  end

  
end
