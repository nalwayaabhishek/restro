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
  def find_restaurent_distance
  all_restaurant = Restaurant.all
  @restaurants = nearest_resturant(all_restaurant, params[:latitude].to_f, params[:longitude].to_f) if params[:latitude].present? and params[:longitude].present?
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
      restaurant['latitude'] = search_restaurant.latitude
      restaurant['longitude'] = search_restaurant.longitude
      restaurant['desc'] = search_restaurant.desc
      restaurants << restaurant
    end
    restaurants
  end
  def nearest_resturant(restaurant_array, user_latidude, user_longitude)
      restaurants = []
      return restaurants if restaurant_array.blank?
      restaurant_array.each do |search_restaurant|
        restaurant = Hash.new 
        restaurant['name'] = search_restaurant.name
        restaurant['thumb_url_image'] = "http://"+request.host_with_port + search_restaurant.avatar.url(:thumb)  
        restaurant['food_type'] = search_restaurant.food_type.name  
        restaurant['desc'] = search_restaurant.desc
        restaurant['latitude'] = search_restaurant.latitude
        restaurant['longitude'] = search_restaurant.longitude
        restaurant['distance'] = calculate_distance(search_restaurant.latitude, search_restaurant.longitude, user_latidude, user_longitude) 
        restaurants << restaurant
      end
      restaurants
  end
 def calculate_distance(restaurant_latitude, restaurant_longitude, user_latidude, user_longitude)
   pi = 3.14
   mean_radius = 6372.797
 lat_diff = (restaurant_latitude - user_latidude)
 long_diff = (restaurant_longitude - user_longitude)
 a = Math.sin(lat_diff / 2) * Math.sin(lat_diff / 2) + Math.cos(user_latidude) * Math.cos(restaurant_latitude) * Math.sin(long_diff / 2) * Math.sin(long_diff / 2);
 c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
 km = mean_radius * c
 end 
end
