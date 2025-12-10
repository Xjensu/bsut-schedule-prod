class AddCourseToSpecialSchedule < ActiveRecord::Migration[8.0]
  def change
    add_column :special_schedules, :course, :integer
  end
end
