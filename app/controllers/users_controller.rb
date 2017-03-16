class UsersController < ApplicationController
before_action :require_login
skip_before_action :require_login, only: [:new, :create]

  def index
    @users = User.all
  end

  def new
    @user=User.new
  end

  def show
    if current_user.id == session[:user_id]#||(params[:id].to_i == session[:user_id]
      @user = current_user#User.find_by_id(session[:user_id])
    else
      redirect_to "/" and return
    end
  end

  def create
    params[:user][:admin]=!!params[:admin]
    @user = User.new(user_params)
    if @user.save
      session[:user_id]=@user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end




  def require_login
    redirect_to "/" unless session.include? :user_id

  end

  private

  def user_params
    params.require(:user).permit(:name, :height, :happiness, :nausea, :tickets, :admin, :password)
  end
end
