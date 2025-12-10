class CreateAcademicPeriods < ActiveRecord::Migration[8.0]
  def change
    create_table :academic_periods do |t|
      t.references :faculty, null: false, foreign_key: true
      t.string :name
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
