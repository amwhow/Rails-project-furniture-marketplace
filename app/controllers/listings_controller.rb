class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :admin_access, only: [:admin]

  # GET /listings
  # GET /listings.json
  def index
    if params[:search].present?
      # search and filter by multiple conditions
      @listings = Listing.where(nil)
      @listings = @listings.search_by_title(params[:search][:title]) if params[:search][:title].present?
      @listings = @listings.search_by_location(params[:search][:location]) if params[:search][:location].present?
      @listings = @listings.search_by_condition(params[:search][:condition]) if params[:search][:condition].present?
      @listings = @listings.search_by_category(params[:search][:category]) if params[:search][:category].present?

      @listings = @listings.min_price(params[:search][:min]) if params[:search][:min].present?
      @listings = @listings.max_price(params[:search][:max]) if params[:search][:max].present?

      @listings = @listings.search_by_delivery(params[:search][:delivery]) if params[:search][:delivery].present?
      
    elsif params[:user].present?
      @listings = User.find(params[:user]).listings 
    elsif params[:cat_name].present?
      @listings = Category.find_by_name(params[:cat_name]).listings
    else
      @listings = Listing.all
    end

    if params[:type] == "json"
      data = @listings.map do |listing|
        [listing.latitude, listing.longitude]
      end 
      render json: {data: data, center: [data[0][0], data[0][1]]}
    end
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    @listing = Listing.find(params[:id])
    # @proximity = Listing.near([@listing.latitude, @listing.longitude], 50)
    # @proximity.length > 1 ? "There are #{@proximity.length - 1} listings within 50kms" : "There are no listing nearby"
    if params[:type] == "json"
      render json: {data: [@listing.latitude, @listing.longitude], center: [@listing.latitude, @listing.longitude]}
    end
    
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def listing_params
      params.require(:listing).permit(:delivery, :location, :description, :price, :title, :condition, :search, :phone, category_ids:[], images: [])
    end

    def admin_access 
      unless current_user.admin? 
        redirect_to root_path, notice: "You aren't allowed to view this page"
      end
    end
end
