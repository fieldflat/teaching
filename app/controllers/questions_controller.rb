class QuestionsController < ApplicationController

  def index
    @questions = Question.all.order(updated_at: "desc")
    @questions = Question.all.page(params[:page]).per(10).order(updated_at: "desc")
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(title: params[:title], content: params[:content], user_id: @current_user.id)

    if @question.save
      if params[:image_name]
        image = params[:image_name]
        @question.image_name = "question#{@question.id}.png"
        File.binwrite("public/img/#{@question.image_name}", image.read)
        @question.save
      end

      flash[:success] = "質問を投稿しました"
      redirect_to("/questions/index")

    else
      flash[:danger] = "質問の投稿に失敗しました"
      render("/questions/new")
    end
  end


end
