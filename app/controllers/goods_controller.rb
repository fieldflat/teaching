class GoodsController < ApplicationController

  def create
    @good = Good.new(user_id: @current_user.id, answer_id: params[:aid])
    @good.save
    flash[:success] = "いい解答をしました"
    @question = Question.find_by(id: params[:qid])
    @answers = Answer.where(question_id: params[:qid]).order(updated_at: "desc")
    redirect_to("/questions/#{params[:qid]}/show")
  end

  def destroy
    @good = Good.find_by(user_id: @current_user.id, answer_id: params[:aid])
    @good.destroy
    flash[:success] = "いい解答を取り消しました"
    @question = Question.find_by(id: params[:qid])
    @answers = Answer.where(question_id: params[:qid]).order(updated_at: "desc")
    redirect_to("/questions/#{params[:qid]}/show")
  end

end
