class QuestionsController < ApplicationController
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  before_action :is_loginned?

  def index
    @questions = Question.all.order(updated_at: "desc")
    @questions = Question.all.page(params[:page]).per(10).order(updated_at: "desc")
  end

  def new
    @question = Question.new
  end

  def show
    @question = Question.find_by(id: params[:qid])
    @answers = Answer.where(question_id: params[:qid]).order(updated_at: "desc")
    @answer = Answer.new
  end

  def create
    @question = Question.new(permit_params)
    @question.user_id = @current_user.id
    @question.save
    #convert_auto_orient("", "")
    flash[:success] = "質問が投稿されました"
    redirect_to("/questions/index")
  end

  def edit
    @question = Question.find_by(id: params[:qid])
  end

  def update
    @question = Question.find_by(id: params[:qid])
    @question.update(permit_params)
    #convert_auto_orient("", "")
    flash[:success] = "質問が更新されました"
    redirect_to("/questions/index")
  end

  def destroy
    @question = Question.find_by(id: params[:qid])
    @question.destroy
    system("rm public/img/#{@question.image_name}")
    flash[:success] = "質問を削除しました"
    redirect_to("/questions/index")
  end

  def orientation(path)
    `identify -format '%[EXIF:Orientation]' ${path}`.to_i
  end

  def auto_orient_options(path)
    case orientation(path)
    when 3 then "-rotate 180"
    when 6 then "-rotate 270"
    when 8 then "-rotate 90"
    end
  end

  def convert_auto_orient(path, new_path)
    system("convert '#{path}' -auto-orient '#{new_path}'")
  end

  def ensure_correct_user
    question = Question.find_by(id: params[:qid].to_i)
    if question
      if @current_user.id != question.user_id
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
        params.require(:question).permit(:title, :content, :image_name)
      end

end
