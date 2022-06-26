class BookCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    params = book_comment_params.merge(user_id: current_user.id)
    @book_comment = BookComment.new(params).save
    redirect_to request.referer
  end

  def destroy
    BookComment.find(params[:id]).destroy
    redirect_to request.referer
  end

  private 

  def book_comment_params
    params.require(:book_comment).permit(:book_id, :body)
  end

  
end
