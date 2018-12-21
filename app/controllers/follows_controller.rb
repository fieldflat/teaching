class FollowsController < ApplicationController

  def create
    @follow = Follow.new(following_id: @current_user.id, followed_id: params[:followed_id])
    flash[:success] = "フォローしました"
    @follow.save
    #redirect_to("/users/#{params[:followed_id]}/show")
    redirect_to("/users/#{params[:followed_id]}/show")
  end

  def destroy
    @follow = Follow.find_by(following_id: @current_user.id, followed_id: params[:followed_id])
    flash[:success] = "フォローを外しました"
    @follow.destroy
    redirect_to("/users/#{params[:followed_id]}/show")
  end

  def show_following
    @members = Follow.where(following_id: params[:following_id])
  end

  def show_followed
    @members = Follow.where(followed_id: params[:followed_id])
  end

end
