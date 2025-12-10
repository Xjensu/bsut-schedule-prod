class StudentGroup < ApplicationRecord
  belongs_to :faculty
  validates :faculty, presence: true
  validates :group_name, presence: true, uniqueness: { scope: :faculty_id }, length: { minimum: 2, maximum: 5 }
end
