require 'spec_helper'
describe RestaurantsController do
	
	it "should search by city" do
	get :search, :format => "json", :city => 'Gurgaonsasdasd'
   	response.status.should == "200 OK".to_i
    response.body.should be_blank
	end	
end
