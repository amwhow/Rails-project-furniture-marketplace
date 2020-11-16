class SavelistingsController < ApplicationController
  before_action :find_listing 
  before_action :find_savelisting, only: [:destroy] 

  def create 
    @listing.savelistings.create(user_id: current_user.id)
  end 

  def destroy
    if !(already_save?)
      flash[:notice] = "Cannot unlike"
    else
      @savelisting.destroy
    end
  end

  private 

  def already_save?
    Savelisting.where(user_id: current_user.id, listing_id:
    params[:listing_id]).exists?
  end

  def find_listing 
    @listing = Listing.find(params[:listing_id])
  end

  def find_savelisting
    @savelisting = @listing.savelistings.find(params[:id])
 end
end
