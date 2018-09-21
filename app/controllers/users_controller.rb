class UsersController < ApplicationController
  def index
    @users = User.all
  end

  before_action :logged_in_user, only:[:index, :edit, :update, :destroy]
  before_action :same_user?, only:[:edit, :update, :destroy]

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @personal_schedules = @user.personal_schedules.all
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile Updated'
      redirect_to @user
    else
      render 'users/edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to root_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def same_user?
      @user = User.find(params[:id])
      unless current_user == @user
        flash[:danger] = 'Invalid user.'
        redirect_to user_url(current_user)
      end
    end
end
