class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(name: params[:name], email: params[:email], password: params[:password])

    if params[:password] == params[:password_confirmation] && @user.save
      @password_error = ""
      redirect_to("/")
    else
      if params[:password] == params[:password_confirmation]
        @password_error = ""
      else
        @password_error = "Password is inconsistent"
      end
      render("users/new")
    end
  end

end
