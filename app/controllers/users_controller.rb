class UsersController < ApplicationController
  def index
    if current_user
      @sheets = current_user.time_sheets
    else
      redirect_to new_user_session_path, notice: 'You are not logged in.'
    end
  end

  def show
    @user = User.find(params[:id])
  end


  def name
    @user.first_name + @user.last_name
  end
end
