class CreateTeachers < ActiveRecord::Migration[8.0]
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :surname
      t.string :patronymic
      t.string :post

      t.timestamps
    end
  end
end
