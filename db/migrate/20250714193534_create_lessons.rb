class CreateLessons < ActiveRecord::Migration[8.0]
  def change
    create_table :lessons do |t|
      t.integer :lesson_type

      t.timestamps
    end
  end
end
