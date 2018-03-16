class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    if params[:search]
      @users = User.search(params[:search])
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user.destroy
    @users = User.all
    flash[:notice] = "User successfully removed."
    render action: "index"
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

  def name
    @user.first_name + @user.last_name
  end
end
