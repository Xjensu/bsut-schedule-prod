class AdminPolicy < ApplicationPolicy
  attr_reader :user, :record
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    faculty_admin?
  end

  def show?
    faculty_admin?
  end

  def create?
    faculty_admin?
  end

  def new?
    create?
  end

  def update?
    faculty_admin?
  end

  def edit?
    update?
  end

  def destroy?
    faculty_admin?
  end

  def editor?
    faculty_admin?
  end

  def schedule_for_date?
    faculty_admin?
  end

  def update_sidebar?
    faculty_admin?
  end

  def copy_under_schedule?
    faculty_admin?
  end

  def faculty_admin?
    return true if user.super_admin?
    user.admin? && user.faculty_id.present?
  end

  # Scope для ограничения доступа к записям
  class Scope < ApplicationPolicy::Scope
    attr_reader :user, :scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.super_admin?
        scope.all
      elsif user.admin?
        scope.all
      else
        scope.none
      end
    end
  end
end
