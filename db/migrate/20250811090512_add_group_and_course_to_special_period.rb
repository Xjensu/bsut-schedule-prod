class AddGroupAndCourseToSpecialPeriod < ActiveRecord::Migration[8.0]
  def change
    add_reference :special_periods, :student_group, null: false, foreign_key: true
    add_column :special_periods, :course, :integer
  end
end
