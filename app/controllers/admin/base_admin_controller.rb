class Admin::BaseAdminController < ApplicationController

  before_action :authenticate_user!
  before_action :verify_admin
  before_action :ensure_faculty_attached

  helper_method :current_faculty

  private

  def verify_admin
    authorize :admin
  end

  def ensure_faculty_attached
    return if current_user.super_admin?
    raise Pundit::NotAuthorizedError unless current_faculty.present?
  end

  def current_faculty
    return @current_faculty if defined?(@current_faculty)

    @current_faculty = if current_user.super_admin?
                         Faculty.find_by(id: params[:faculty_id])
                       else
                         current_user.faculty
                       end
  end

  # Guard that the provided faculty_id matches the current admin's faculty
  def enforce_faculty_scope!(faculty_id)
    return if current_user.super_admin?
    return if faculty_id.blank? # for resources that are not faculty-scoped

    unless faculty_id.to_i == current_faculty.id
      raise Pundit::NotAuthorizedError
    end
  end
end