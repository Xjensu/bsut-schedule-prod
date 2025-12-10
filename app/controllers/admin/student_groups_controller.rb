class Admin::StudentGroupsController < Admin::BaseAdminController
  def index
    ensure_faculty_param!
    @groups = StudentGroup.where(faculty_id: current_faculty.id).order(:group_name)
    @academic_periods = AcademicPeriod.where(faculty_id: current_faculty.id)
  end

  def new
    @group = StudentGroup.new
  end

  def create
    ensure_faculty_param!
    @group = StudentGroup.new(create_params.merge(faculty_id: current_faculty.id))

    respond_to do |format|
      if @group.save
        format.turbo_stream
      else
        format.turbo_stream { render :create_error }
      end
    end
  end

  def destroy
    ensure_faculty_param!
    @group = current_faculty.student_groups.find(params[:id])
    faculty_id = @group.faculty_id
    respond_to do |format|
      if @group.destroy
        @groups = StudentGroup.where(faculty_id: faculty_id).order(:group_name)
        format.turbo_stream
      else
        format.turbo_stream { render :destroy_error, status: :unprocessable_entity }
      end
    end
  end

  private

  def create_params
    params.require(:student_group).permit(:group_name)
  end

  def ensure_faculty_param!
    enforce_faculty_scope!(params[:faculty_id] || current_faculty&.id)
  end
end
