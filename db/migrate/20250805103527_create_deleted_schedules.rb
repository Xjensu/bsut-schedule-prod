class CreateDeletedSchedules < ActiveRecord::Migration[8.0]
  def change
    create_table :deleted_schedules do |t|
      t.references :schedule, null: false, foreign_key: true
      t.date :date
      t.references :student_group, null: false, foreign_key: true
      t.integer :course

      t.timestamps
    end
  end
end
