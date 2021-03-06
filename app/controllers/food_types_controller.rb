class FoodTypesController < ApplicationController
  # GET /food_types
  # GET /food_types.json
  def index
    @food_types = FoodType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @food_types }
    end
  end

  # GET /food_types/1
  # GET /food_types/1.json
  def show
    @food_type = FoodType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @food_type }
    end
  end

  # GET /food_types/new
  # GET /food_types/new.json
  def new
    @food_type = FoodType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @food_type }
    end
  end

  # GET /food_types/1/edit
  def edit
    @food_type = FoodType.find(params[:id])
  end

  # POST /food_types
  # POST /food_types.json
  def create
    @food_type = FoodType.new(params[:food_type])

    respond_to do |format|
      if @food_type.save
        format.html { redirect_to @food_type, notice: 'Food type was successfully created.' }
        format.json { render json: @food_type, status: :created, location: @food_type }
      else
        format.html { render action: "new" }
        format.json { render json: @food_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /food_types/1
  # PUT /food_types/1.json
  def update
    @food_type = FoodType.find(params[:id])

    respond_to do |format|
      if @food_type.update_attributes(params[:food_type])
        format.html { redirect_to @food_type, notice: 'Food type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @food_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /food_types/1
  # DELETE /food_types/1.json
  def destroy
    @food_type = FoodType.find(params[:id])
    @food_type.destroy

    respond_to do |format|
      format.html { redirect_to food_types_url }
      format.json { head :no_content }
    end
  end
end
