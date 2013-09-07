class AddPhotoToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :photo, :string
  end
end
