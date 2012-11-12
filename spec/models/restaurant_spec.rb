require 'spec_helper'
describe Restaurant  do
	fixtures :restaurants
	  before(:each) do
    @restaurant =  restaurants(:restaurant_yellow)
    @city = cities(:city_jaipur)
	end
it "should save a  object" do
 @restaurant.should be_valid	
end	
it "should search by city" do
	search_string = "Jaipur"
 Restaurant.search(search_string).first.city.should == "Jaipur"
end	
end
