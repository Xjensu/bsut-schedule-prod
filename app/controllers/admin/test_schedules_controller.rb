class Admin::TestSchedulesController < Admin::BaseAdminController
  before_action :set_academic_period, only: [:index]
  before_action :ensure_faculty_scope_from_params, only: [:index, :show, :editor, :create, :update, :destroy]

  def index
    @special_period = SpecialPeriod.new(
      academic_period_id: params[:academic_period_id],
      student_group_id: params[:group_id],
      course: params[:course],
      name: :test
    )

    @special_periods = SpecialPeriod.where(
      academic_period_id: params[:academic_period_id],
      student_group_id: params[:group_id],
      course: params[:course],
      name: :test
    ).order(:start_date)

    @special_schedule = SpecialSchedule.new
    @special_schedules = SpecialSchedule.where(special_period_id: @special_periods.ids)
    @times = ['08:30', '10:10', '11:45', '14:00', '15:35', '17:10', '18:45']
  end

  def show
    @special_period = SpecialPeriod.find(params[:id])
    enforce_faculty_scope!(@special_period.academic_period.faculty_id)
    @schedules = SpecialSchedule.where(special_period_id: @special_period.id)

    @schedule_renderer = ScheduleRenderer.new(
          self,
          default_times: ['08:30', '10:10', '11:45', '14:00', '15:35', '17:10', '18:45'],
          schedules: @schedules,
          param: { group_id:  @special_period.student_group_id, academic_period_id: @special_period.academic_period_id, special_period_id: @special_period.id, course: @special_period.course },
          card_stimulus: { controller: 'test-schedule-cards', action: 'click->test-schedule-cards#clicked' }, #action: 'dragstart->transfer-schedule-card#handleDragStart' },
          # card_attributes: { draggable: 'true', transfer_schedule_card_target: params[:target] },
          partial: 'shared/schedule/transfer_schedule_container'
        )
  end

  def editor
    permitted_params = editor_params
    @special_period = SpecialPeriod.find(permitted_params[:special_period_id])
    enforce_faculty_scope!(@special_period.academic_period.faculty_id)
    @special_period_id = permitted_params[:special_period_id]
    @group_id = permitted_params[:student_group_id]
    @course = permitted_params[:course]
    @time = permitted_params[:start_time]
    @lesson = Lesson.find_by(lesson_type: :test)

    @schedule = if permitted_params[:id].present?
                  SpecialSchedule.find(permitted_params[:id])
                else
                  SpecialSchedule.new(
                    student_group_id: @group_id,
                    special_period_id: @special_period_id,
                    start_time: @time,
                    course: @course,
                    lesson_id: @lesson.id
                  )
                end

    @selected_teacher_id = @schedule.teacher_id
    @teachers = TeachersFetcher.new(
      search_query: params[:teacher_search],
      limit: params[:teacher_search].present? ? 10 : nil,
      priority_teacher_id: @selected_teacher_id,
    ).call.order(name: :asc)

    @classrooms = Classroom.all
    
    respond_to do |format|
      format.turbo_stream
    end
  end

  def new
  end

  def create
    @special_schedule = SpecialSchedule.new(create_params.merge( subject_id: find_or_create_subject(create_params[:subject_id]) ))
    enforce_faculty_scope_from_schedule(@special_schedule)
    Rails.logger.info("Creating SpecialSchedule with params: #{create_params.inspect}")
    if @special_schedule.save
      Rails.logger.info("SpecialSchedule created successfully: #{@special_schedule.inspect}")
      redirect_back fallback_location: root_path, notice: "Сообщение об успехе", allow_other_host: false
    else
      Rails.logger.error("Error creating SpecialSchedule: #{@special_schedule.errors.full_messages}")
      redirect_back fallback_location: root_path, notice: "ошибка при создании, #{@special_schedule.errors.full_messages}", allow_other_host: false
    end
  end

  def edit
  end

  def update
    puts params
    @special_schedule = SpecialSchedule.find(params[:id])
    enforce_faculty_scope_from_schedule(@special_schedule)
    if @special_schedule.update( update_params.merge( subject_id: find_or_create_subject(create_params[:subject_id]) ))
      redirect_back fallback_location: root_path, notice: "Сообщение об успехе", allow_other_host: false
    else
      redirect_back fallback_location: root_path, notice: "ошибка при обновлении, #{@special_schedule.errors.full_messages}", allow_other_host: false
    end
  end

  def destroy
    @special_schedule = SpecialSchedule.find(params[:id])
    enforce_faculty_scope_from_schedule(@special_schedule)
    if @special_schedule.destroy
      redirect_back fallback_location: root_path, notice: "Сообщение об успехе", allow_other_host: false
    else
      redirect_back fallback_location: root_path, notice: "ошибка при удалении, #{@special_schedule.errors.full_messages}", allow_other_host: false
    end
  end

  private 

  def create_params
    params.require(:special_schedule).permit(:teacher_id, :special_period_id, :student_group_id, :start_time, :classroom_id, :lesson_id, :course, :subject_id)
  end

  def update_params
    params.require(:special_schedule).permit(:teacher_id, :special_period_id, :student_group_id, :start_time, :classroom_id, :lesson_id, :course, :subject_id)
  end

  def set_academic_period
    @academic_period = AcademicPeriod.find(params[:academic_period_id])
    enforce_faculty_scope!(@academic_period.faculty_id)
  end

  def editor_params
    params.require(:special_schedule).permit(:special_period_id, :student_group_id, :course, :start_time, :id)
  end

  def find_or_create_subject(name)
    return nil if name.blank?
    subject = Subject.where(name: name)
    if subject.present?
      subject = subject.ids.first
    else 
      subject = Subject.new(name: name.to_s)
      subject.save!
      subject = subject.id
    end
    subject
  end

  def enforce_faculty_scope_from_schedule(schedule)
    if schedule.special_period_id.present?
      special_period = SpecialPeriod.find(schedule.special_period_id)
      enforce_faculty_scope!(special_period.academic_period.faculty_id)
    end

    if schedule.student_group_id.present?
      group = StudentGroup.find(schedule.student_group_id)
      enforce_faculty_scope!(group.faculty_id)
    end
  end

  def ensure_faculty_scope_from_params
    if params[:academic_period_id].present?
      enforce_faculty_scope!(AcademicPeriod.find(params[:academic_period_id]).faculty_id)
    end

    group_id = params[:group_id] || params[:student_group_id] || params.dig(:special_schedule, :student_group_id)
    enforce_faculty_scope!(StudentGroup.find(group_id).faculty_id) if group_id.present?

    if params[:special_period_id].present?
      enforce_faculty_scope!(SpecialPeriod.find(params[:special_period_id]).academic_period.faculty_id)
    end
  end

end
