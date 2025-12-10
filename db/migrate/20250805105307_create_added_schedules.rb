class CreateAddedSchedules < ActiveRecord::Migration[8.0]
  def change
    create_table :added_schedules do |t|
      t.references :schedule, null: false, foreign_key: true
      t.references :classroom, foreign_key: true, null: true
      t.references :teacher, foreign_key: true, null: true
      t.date :date, null: false
      t.time :time
      t.references :student_group, null: false, foreign_key: true
      t.integer :course, null: false

      t.timestamps
    end
  end
end
