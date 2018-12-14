class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user
  add_flash_types :success, :info, :warning, :danger

    def set_current_user
      @current_user = User.find_by(id: session[:user_id])
    end

    def is_loginned?
      if !@current_user
        flash[:danger] = "ログインをしてください"
        redirect_to("/")
      end
    end

end
