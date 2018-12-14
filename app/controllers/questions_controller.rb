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
  end

  def create
    @question = Question.new(title: params[:title], content: params[:content], user_id: @current_user.id)

    if @question.save
      if params[:image_name]
        image = params[:image_name]
        @question.image_name = "question#{@question.id}.png"
        File.binwrite("public/img/#{@question.image_name}", image.read)
        @question.save
        convert_auto_orient("public/img/#{@question.image_name}", "public/img/#{@question.image_name}")
      end

      flash[:success] = "質問を投稿しました"
      redirect_to("/questions/index")

    else
      flash[:danger] = "質問の投稿に失敗しました"
      render("/questions/new")
    end
  end

  def edit
    @question = Question.find_by(id: params[:qid])
  end

  def update
    @question = Question.find_by(id: params[:qid])

    @question.title = params[:title]
    @question.content = params[:content]

    if @question.save
      if params[:image_name]
        image = params[:image_name]
        @question.image_name = "question#{@question.id}.png"
        File.binwrite("public/img/#{@question.image_name}", image.read)
        @question.save
        convert_auto_orient("public/img/#{@question.image_name}", "public/img/new"+"#{@question.image_name}")
      end


      flash[:success] = "質問を編集しました"
      redirect_to("/questions/index")

    else
      flash[:danger] = "質問の編集に失敗しました"
      render("/questions/new")
    end
  end

  def destroy
    @question = Question.find_by(id: params[:qid])
    @question.destroy
    flash[:sucess] = "質問を削除しました"
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
    #system("convert #{auto_orient_options(path)} -strip '#{path}' '#{new_path}'")
    #system("convert -rotate 90 -strip '#{path}' '#{new_path}'")
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

end
