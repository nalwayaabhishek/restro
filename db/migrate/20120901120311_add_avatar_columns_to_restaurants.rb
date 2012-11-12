class AddAvatarColumnsToRestaurants < ActiveRecord::Migration
   def self.up
    add_attachment :restaurants, :avatar
  end

  def self.down
    remove_attachment :restaurants, :avatar
  end
end
