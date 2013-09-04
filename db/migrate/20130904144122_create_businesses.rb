class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :kind
      t.string :address
      t.string :town
      t.string :postcode
      t.string :telephone
      t.string :website
      t.string :email
      t.string :twitter
      t.string :facebook
      t.text :services
      t.text :profile

      t.timestamps
    end
  end
end
