class CreateWeeklySchedules < ActiveRecord::Migration
  def change
    create_table :weekly_schedules do |t|
      t.string :monday_opening
      t.string :monday_closing
      t.string :tuesday_opening
      t.string :tuesday_closing
      t.string :wednesday_opening
      t.string :wednesday_closing
      t.string :thursday_opening
      t.string :thursday_closing
      t.string :friday_opening
      t.string :friday_closing
      t.string :saturday_opening
      t.string :saturday_closing
      t.string :sunday_opening
      t.string :sunday_closing
      t.integer :business_id

      t.timestamps
    end
  end
end
