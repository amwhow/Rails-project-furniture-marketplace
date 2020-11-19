class SavelistingsController < ApplicationController
  before_action :find_listing 
  before_action :find_savelisting, only: [:destroy] 

  # create savelistings and link it to the current user
  def create 
    @listing.savelistings.create(user_id: current_user.id)
    redirect_to @listing
  end 

  
  def destroy
    # prevent bugs
    if !(already_save?)
      flash[:notice] = "Cannot unlike"
    else
      @savelisting.destroy
    end
    redirect_to @listing
  end

  private 

  # examine if there is a record linked to both current user and current listing
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
