class DeletedSchedule < ApplicationRecord
  belongs_to :schedule
  belongs_to :student_group
end
