class CreateFaculties < ActiveRecord::Migration[8.0]
  def change
    create_table :faculties do |t|
      t.string :full_name
      t.string :short_name

      t.timestamps
    end
  end
end
