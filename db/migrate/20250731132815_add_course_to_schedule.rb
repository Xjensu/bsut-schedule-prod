class AddCourseToSchedule < ActiveRecord::Migration[8.0]
  def change
    add_column :schedules, :course, :integer
  end
end
