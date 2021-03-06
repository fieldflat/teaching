class UsersController < ApplicationController
  before_action :is_loginned?, {only: [:logout]}
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def new
    @user = User.new
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user
      @questions = Question.where(user_id: @user.id).page(params[:page]).per(10).order(updated_at: "desc")
      @all_likes = Like.all
      @all_goods = Good.all
      @like_count = 0
      @good_count = 0
      @following_num = Follow.where(following_id: params[:id]).count
      @followed_num = Follow.where(followed_id: params[:id]).count
      @all_likes.each do |l|
        liked_question = Question.find_by(id: l.post_id)
        liked_user = User.find_by(id: liked_question.user_id)
        if @user.id == liked_user.id
          @like_count += 1
        end
      end

      @all_goods.each do |g|
        liked_answer = Answer.find_by(id: g.answer_id)
        liked_user = User.find_by(id: liked_answer.user_id)
        if @user.id == liked_user.id
          @good_count += 1
        end
      end

    else
      flash[:danger] = "ユーザが存在しません"
      redirect_to("/")
    end
  end

  def create
    #@user = User.new(name: params[:name], email: params[:email], password: params[:password], image_name: "default_user.png")
    @user = User.new(name: params[:name], email: params[:email], password: params[:password])

    if params[:password] == params[:password_confirmation] && @user.save
      session[:user_id] = @user.id
      @password_error_message = ""
      flash[:success] = "新規登録に成功しました"
      redirect_to("/")
    else
      if params[:password] == params[:password_confirmation]
        flash[:danger] = "新規登録に失敗しました"
        @password_error_message = ""
      else
        flash[:danger] = "パスワードが一致していません"
        @password_error_message = "Password is inconsistent"
      end
      render("users/new")
    end
  end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(name: params[:name], email: params[:email])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      @login_error_message = ""
      flash[:success] = "ログインに成功しました"
      redirect_to("/")
    else
      @login_error_message = "ユーザ名またはパスワードが間違っています"
      @user = User.new
      @user.name = params[:name]
      @user.email = params[:email]
      flash[:danger] = "ログインに失敗しました"
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "ログアウトしました"
    redirect_to("/")
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.update(permit_params)
    flash[:success] = "プロフィールを編集しました"
    redirect_to("/users/#{params[:id]}/show")
#    @user.name = params[:name]
#    @user.introduction = params[:introduction]

#    if params[:image_name]
#      image = params[:image_name]
#      @user.image_name = "#{@user.id}.png"
#      File.binwrite("public/img/#{@user.image_name}", image.read)
#      convert_auto_orient("public/img/#{@user.image_name}", "public/img/#{@user.image_name}")
#    end

#    flash[:success] = "ユーザ情報を編集しました"
#    @user.save
#    redirect_to("/users/#{@user.id}/show")
  end

  def convert_auto_orient(path, new_path)
    #system("convert #{auto_orient_options(path)} -strip '#{path}' '#{new_path}'")
    #system("convert -rotate 90 -strip '#{path}' '#{new_path}'")
    system("convert '#{path}' -auto-orient '#{new_path}'")
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:danger] = "権限がありません"
      redirect_to("/")
    end
  end

  private
      def permit_params
        params.require(:user).permit(:name, :introduction, :image_name)
      end


end
