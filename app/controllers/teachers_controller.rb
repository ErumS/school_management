class TeachersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @teachers = Teacher.all
    if @teachers
      respond_to do |format|
        format.json {render json: {teachers: @teachers}, status: :ok }
        format.html
      end
    else
      respond_to do |format| 
        format.json {render json: {error: @teachers.errors}, status: :not_found}
        format.html {render html: {message: @teachers.errors}.messages, status: :not_found}
      end
    end
  end 

  def show
    begin
      @teacher = Teacher.find(params[:id])
      respond_to do |format|
        format.json {render json: {teacher: @teacher}, status: :ok}
        format.html
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found} 
        format.html {render html: {error: e.message}, status: :not_found}
      end
    end
  end

  def new
    @teacher = Teacher.new
  end 

  def edit
    @teacher = Teacher.find(params[:id])
  end

  def create
    begin
      @teacher = Teacher.new(teacher_params)
      @school = School.find_by_id(params[:school_id])
      @classroom = Classroom.find_by_id(params[:classroom_id])
      @subject = Subject.find_by_id(params[:subject_id])
      @student = Student.find_by_id(params[:student_ids])
      if @teacher.save
        respond_to do |format|
          format.json {render json: {teacher: @teacher}, status: :ok}
          format.html {redirect_to :back}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @teacher.errors}, status: :unprocessable_entity}
          format.html {render html: {message: @teacher.errors.messages}, status: :unprocessable_entity}
        end
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found}
        format.html {render html: {error: e.message}, status: :not_found}
      end
    end
  end 

  def update
    begin
      @teacher = Teacher.find(params[:id]) 
      if @teacher.update(teacher_params)  
        respond_to do |format|
          format.json {render json: {teacher: @teacher}, status: :ok}
          format.html {redirect_to @teacher}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @teacher.errors}, status: :unprocessable_entity}
          format.html {render 'edit'}
        end
      end   
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found}
        format.html {render 'edit'}
      end
    end    
  end
  
  def destroy
    begin
      @teacher = Teacher.find(params[:id])
      if @teacher.destroy
        respond_to do |format|
          format.json {render json: {message: 'Successfully deleted'}, status: :ok}
          format.html {redirect_to :back}
        end  
      else
        respond_to do |format|
          format.json {render json: {error: @teacher.errors}, status: :unprocessable_entity}
          format.html {redirect_to @teacher}
        end  
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found}
        format.html {redirect_to @teacher}
      end
    end
  end

  private
    def teacher_params
      params.require(:teacher).permit(:name, :subject_name, :salary, :school_id, :classroom_id, :subject_id, :student_ids)
    end
end