class AnswersController < ApplicationController
  before_action :ensure_correct_user, {only: [:destroy]}

  def create
    @answer = Answer.new(permit_params)
    @answer.user_id = @current_user.id
    @answer.question_id = params[:qid]
    @answer.save
    #convert_auto_orient("", "")
    flash[:success] = "質問が投稿されました"
    redirect_to("/questions/#{params[:qid].to_i}/show")
#    @answer = Answer.new(user_id: @current_user.id, question_id: params[:qid].to_i, content: params[:content])
#
#      if params[:image_name]
#        image = params[:image_name]
#        @answer.image_name = "answer#{@answer.id}.png"
#        File.binwrite("public/img/#{@answer.image_name}", image.read)
#        @answer.save
#        convert_auto_orient("public/img/#{@answer.image_name}", "public/img/#{@answer.image_name}")
#      end
#
#      flash[:success] = "返信されました！"
#      redirect_to("/questions/#{params[:qid]}/show")
#
#    else
#      flash[:danger] = "返信できませんでした(返信が空欄である可能性があります)"
#      @question = Question.find_by(id: params[:qid])
#      @answers = Answer.where(question_id: params[:qid]).order(updated_at: "desc")
#      render("questions/show")
#    end
  end

  def destroy
    @answer = Answer.find_by(id: params[:aid])
    @question = Question.find_by(id: @answer.question_id)
    if @answer.destroy
      if @answer.image_name
        system("rm public/img/#{@answer.image_name}")
      end
      flash[:success] = "返信を削除しました"
      redirect_to("/questions/#{@question.id}/show")
    else
      flash[:danger] = "返信の削除に失敗しました"
      redirect_to("/questions/index")
    end
  end

  def convert_auto_orient(path, new_path)
    #system("convert #{auto_orient_options(path)} -strip '#{path}' '#{new_path}'")
    #system("convert -rotate 90 -strip '#{path}' '#{new_path}'")
    system("convert '#{path}' -auto-orient '#{new_path}'")
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

  private
      def permit_params
        params.require(:answer).permit(:content, :image_name)
      end

end
