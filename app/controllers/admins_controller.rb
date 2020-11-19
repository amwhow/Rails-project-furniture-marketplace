class AdminsController < ApplicationController
  def index
  end 

  def deny_access 
    redirect_to root_path
  end

  private 

end
