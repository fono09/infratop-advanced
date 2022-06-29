class RelationshipsController < ApplicationController
  before :authenticate_user!

  def create
    Relationship.new(
      followed_id: params[:user_id],
      follower_id: current_user.id
    ).save
    redirect_to request.referer
  end

  def destroy
      Relationship.find_by(
        followed_id: params[:user_id],
        follower_id: current_user.id
      ).destroy
    redirect_to request.referer
  end

end
