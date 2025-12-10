class CreateSpecialSchedules < ActiveRecord::Migration[8.0]
  def change
    create_table :special_schedules do |t|
      t.references :special_period, null: false, foreign_key: true
      t.references :student_group, null: false, foreign_key: true
      t.references :teacher, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true
      t.references :classroom, null: false, foreign_key: true
      t.integer :day_of_week
      t.time :start_time
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
