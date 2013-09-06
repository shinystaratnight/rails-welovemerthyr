class AddLongitudeLatitudeToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :lat, :float
    add_column :businesses, :lon, :float
  end
end
