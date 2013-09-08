class AddContactToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :contact, :string
  end
end
