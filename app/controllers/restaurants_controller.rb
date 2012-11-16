class RestaurantsController < ApplicationController

  before_filter :load_type_and_city
  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = Restaurant.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @restaurants }
    end
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
    @restaurant = Restaurant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @restaurant }
    end
  end

  # GET /restaurants/new
  # GET /restaurants/new.json
  def new
    @restaurant = Restaurant.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @restaurant }
    end
  end

  # GET /restaurants/1/edit
  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.create(params[:restaurant])

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render json: @restaurant, status: :created, location: @restaurant }
      else
        format.html { render action: "new" }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /restaurants/1
  # PUT /restaurants/1.json
  def update
    @restaurant = Restaurant.find(params[:id])

    respond_to do |format|
      if @restaurant.update_attributes(params[:restaurant])
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy

    respond_to do |format|
      format.html { redirect_to restaurants_url }
      format.json { head :no_content }
    end
  end
  def search
    search_restaurants = Restaurant.search(params[:city])
    @restaurants = map_to_search_result(search_restaurants)
    respond_to do |format|
      format.json { render json: @restaurants }
    end
  end
  private
  def load_type_and_city
    @cities=  City.all
    @food_types = FoodType.all
  end
  def map_to_search_result(search_restaurants)
    restaurants = []
    return restaurants if search_restaurants.blank?
    search_restaurants.each do |search_restaurant|
      restaurant = Hash.new 
      restaurant['name'] = search_restaurant.name
      restaurant['thumb_url_image'] = "http://"+request.host_with_port + search_restaurant.avatar.url(:thumb)  
      restaurant['food_type'] = search_restaurant.food_type.name  
      restaurant['desc'] = search_restaurant.desc
      restaurants << restaurant
    end
    restaurants
  end
end
