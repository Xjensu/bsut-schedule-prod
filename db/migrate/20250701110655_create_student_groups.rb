class CreateStudentGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :student_groups do |t|
      t.string :group_name
      t.references :faculty, null: false, foreign_key: true

      t.timestamps
    end
  end
end
