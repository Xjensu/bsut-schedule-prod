class Admin::FacultiesController < Admin::BaseAdminController
  before_action :get_faculty, only: [:edit, :update, :destroy]
  before_action :ensure_faculty_scope, only: [:edit, :update, :destroy]

  def index
    # Суперадмин видит все факультеты, обычный админ только свой
    @faculties = if current_user.super_admin?
                   Faculty.order(:short_name)
                 else
                   Array(current_faculty)
                 end
  end

  def new
    # Для админа факультета создание нового факультета запрещено
    raise Pundit::NotAuthorizedError
  end

  def create
    raise Pundit::NotAuthorizedError
  end

  def edit
  end

  def update
    respond_to do |format|
      if @faculty.update(faculty_params)
        format.turbo_stream
        format.html { redirect_to faculty_index_path, notice: 'Faculty was successfully updated.' }
      else
        format.turbo_stream { render :update }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @faculty.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to faculty_index_path, notice: 'Faculty was successfully deleted.' }
    end
  end

  private

  def get_faculty
    @faculty = Faculty.find(params[:id])
  end

  def ensure_faculty_scope
    enforce_faculty_scope!(@faculty.id)
  end

  def faculty_params
    params.require(:faculty).permit(:full_name, :short_name, :processing_time, :src)
  end
end
