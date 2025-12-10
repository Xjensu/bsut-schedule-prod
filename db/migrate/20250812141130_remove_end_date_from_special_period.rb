class RemoveEndDateFromSpecialPeriod < ActiveRecord::Migration[8.0]
  def change
    remove_column :special_periods, :end_date, :date
  end
end
