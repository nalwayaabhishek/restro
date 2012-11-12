class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.references :food_type
      t.text :desc
      t.references :city
      t.timestamps
    end
  end
end
