class Teacher < ApplicationRecord
  validates :name, :surname, :patronymic, :post, presence: { message: "can't be blank" }


  def full_name
    "#{surname} #{name} #{patronymic}".strip
  end
end
