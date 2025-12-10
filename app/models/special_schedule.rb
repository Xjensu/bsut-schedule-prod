class SpecialSchedule < ApplicationRecord
  belongs_to :special_period
  belongs_to :student_group
  belongs_to :teacher
  belongs_to :subject
  belongs_to :classroom
  belongs_to :lesson
end
