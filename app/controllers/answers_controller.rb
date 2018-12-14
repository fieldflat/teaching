class AnswersController < ApplicationController
  before_action :ensure_correct_user, {only: [:destroy]}

  def create
    @answer = Answer.new(user_id: @current_user.id, question_id: params[:qid].to_i, content: params[:content])

    if @answer.save
      if params[:image_name]
        image = params[:image_name]
        @answer.image_name = "answer#{@answer.id}.png"
        File.binwrite("public/img/#{@answer.image_name}", image.read)
        @answer.save
      end

      flash[:success] = "返信されました！"
      redirect_to("/questions/#{params[:qid]}/show")

    else
      flash[:danger] = "返信できませんでした(返信が空欄である可能性があります)"
      @question = Question.find_by(id: params[:qid])
      @answers = Answer.where(question_id: params[:qid]).order(updated_at: "desc")
      render("questions/show")
    end
  end

  def destroy
    @answer = Answer.find_by(id: params[:aid])
    @question = Question.find_by(id: @answer.question_id)
    if @answer.destroy
      flash[:success] = "返信を削除しました"
      redirect_to("/questions/#{@question.id}/show")
    else
      flash[:danger] = "返信の削除に失敗しました"
      redirect_to("/questions/index")
    end

  end


  def ensure_correct_user
    answer = Answer.find_by(user_id: @current_user.id)
    if answer
      if @current_user.id != answer.user_id
        flash[:danger] = "権限がありません"
        redirect_to("/questions/index")
      end

    else
      flash[:danger] = "質問が存在しません"
      redirect_to("/questions/index")
    end
  end

end
