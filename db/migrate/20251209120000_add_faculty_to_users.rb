class AddFacultyToUsers < ActiveRecord::Migration[8.0]
  def change
    add_reference :users, :faculty, foreign_key: true, null: true
    add_column :users, :super_admin, :boolean, default: false, null: false
  end
end
