class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :trackable,
         :session_limitable

  belongs_to :faculty, optional: true

  validates :faculty, presence: true, if: :faculty_required?

  def admin?
    super_admin? || self[:admin]
  end

  def super_admin?
    self[:super_admin]
  end

  private

  def faculty_required?
    admin? && !super_admin?
  end
end
