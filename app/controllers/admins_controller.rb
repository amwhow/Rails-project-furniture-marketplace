class AdminsController < ApplicationController
  def index
  end 

  def destroy 
    @user = User.find(params[:delete_user_id]) 
    @user.destroy
    redirect_to dashboard_path
  end

  private 

end
