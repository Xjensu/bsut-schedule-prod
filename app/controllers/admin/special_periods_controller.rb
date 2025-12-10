class Admin::SpecialPeriodsController < Admin::BaseAdminController
  before_action :ensure_faculty_scope_from_params, only: [:create]
  before_action :set_special_period, only: [:destroy]
  def index
  end

  def new
  end

  def create
    case create_params[:name]
    when "test"
      create_test_period create_params
    when "exam"
      create_exam_period create_params
    end
    
    if request.referer.present? && URI(request.referer).host == request.host
      redirect_back fallback_location: root_path, notice: "Сообщение об успехе", allow_other_host: false
    else
      redirect_to root_path
    end
  end

  def destroy
    @special_period.destroy
    if request.referer.present? && URI(request.referer).host == request.host
      redirect_back fallback_location: root_path, notice: "Сообщение об успехе", allow_other_host: false
    else
      redirect_to root_path
    end
  end

  private 

  def create_params
    params.require(:special_period).permit(:academic_period_id, :course, :student_group_id, :start_date, :name)
  end

  def set_special_period
    @special_period = SpecialPeriod.find(params[:id])
    enforce_faculty_scope!(@special_period.academic_period.faculty_id)
  end


  def create_test_period(create_params)
    SpecialPeriod.new(create_params.merge(start_date: Date.parse(create_params[:start_date]))).save
  end

  def create_exam_period(create_params)
    SpecialPeriod.new(create_params.merge(start_date: Date.parse(create_params[:start_date]))).save
  end

  def ensure_faculty_scope_from_params
    if create_params[:academic_period_id].present?
      academic_period = AcademicPeriod.find(create_params[:academic_period_id])
      enforce_faculty_scope!(academic_period.faculty_id)
    end

    if create_params[:student_group_id].present?
      group = StudentGroup.find(create_params[:student_group_id])
      enforce_faculty_scope!(group.faculty_id)
    end
  end
end
