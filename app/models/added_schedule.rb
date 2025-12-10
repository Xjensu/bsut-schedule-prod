class AddedSchedule < ApplicationRecord
  belongs_to :schedule
  belongs_to :classroom, optional: true
  belongs_to :teacher, optional: true
  belongs_to :student_group
end
