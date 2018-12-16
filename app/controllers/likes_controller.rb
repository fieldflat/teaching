class LikesController < ApplicationController
  before_action :is_loginned?

  def create
    @like = Like.new(user_id: @current_user.id, post_id: params[:post_id])
    @like.save
    flash[:success] = "いいねをしました"
    redirect_to("/questions/index")
  end

  def destroy
    @like = Like.find_by(user_id: @current_user.id, post_id: params[:post_id])
    @like.destroy
    flash[:success] = "いいねを取り消しました"
    redirect_to("/questions/index")
  end

  def show_create
    @like = Like.new(user_id: @current_user.id, post_id: params[:post_id])
    @like.save
    flash[:success] = "いいねをしました"
    redirect_to("/questions/#{params[:post_id]}/show")
  end

  def show_destroy
    @like = Like.find_by(user_id: @current_user.id, post_id: params[:post_id])
    @like.destroy
    flash[:success] = "いいねを取り消しました"
    redirect_to("/questions/#{params[:post_id]}/show")
  end

  def user_show_create
    @like = Like.new(user_id: @current_user.id, post_id: params[:post_id])
    @like.save
    flash[:success] = "いいねをしました"
    redirect_to("/users/#{params[:user_id]}/show")
  end

  def user_show_destroy
    @like = Like.find_by(user_id: @current_user.id, post_id: params[:post_id])
    @like.destroy
    flash[:success] = "いいねを取り消しました"
    redirect_to("/users/#{params[:user_id]}/show")
  end

end
