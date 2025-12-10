class Admin::UsersController < Admin::BaseAdminController
  before_action :ensure_super_admin!
  before_action :set_user, only: [:update]

  def index
    @faculties = Faculty.order(:short_name)
    @users = User.includes(:faculty).order(:email)
  end

  def update
    attrs = user_admin_params
    admin_flag = ActiveModel::Type::Boolean.new.cast(attrs[:admin])
    super_flag = ActiveModel::Type::Boolean.new.cast(attrs[:super_admin])

    @user.super_admin = super_flag
    @user.admin = super_flag || admin_flag
    @user.faculty_id = admin_flag ? attrs[:faculty_id] : nil

    if admin_flag && @user.faculty_id.blank? && !@user.super_admin?
      redirect_back fallback_location: admin_users_path, alert: "Укажите факультет для администратора."
      return
    end

    if @user == current_user && !@user.super_admin?
      redirect_back fallback_location: admin_users_path, alert: "Нельзя лишить себя прав супер-админа." and return if super_flag == false
    end

    if @user.save
      redirect_back fallback_location: admin_users_path, notice: "Права обновлены."
    else
      redirect_back fallback_location: admin_users_path, alert: @user.errors.full_messages.to_sentence
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_super_admin!
    raise Pundit::NotAuthorizedError unless current_user.super_admin?
  end

  def user_admin_params
    puts "aAAAA", params.inspect
    params.permit(:admin, :faculty_id, :super_admin)
  end
end
