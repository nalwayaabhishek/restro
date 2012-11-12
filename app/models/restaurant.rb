class Restaurant < ActiveRecord::Base
  attr_accessible  :desc, :food_type_id, :name, :avatar, :city_id
  validates :name, :presence => true 
  belongs_to :city
  belongs_to :food_type
  has_attached_file :avatar,:styles => {:thumb=>"100*100>",:medium=>"300*300" }
  
  def self.search(search_string)
    city = City.where(:name => search_string).first
    return "" if city.nil?
    city.restaurants
  end
  
end
