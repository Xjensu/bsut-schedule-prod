class CreateSpecialPeriods < ActiveRecord::Migration[8.0]
  def change
    create_table :special_periods do |t|
      t.references :academic_period, null: false, foreign_key: true
      t.string :name
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
