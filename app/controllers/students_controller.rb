class StudentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @students = Student.all
    if @students
      respond_to do |format|
        format.json {render json: {students: @students}, status: :ok }
        format.html
      end
    else
      respond_to do |format| 
        format.json {render json: {error: @students.errors}, status: :not_found}
        format.html {render html: {message: @students.errors.messages}, status: :not_found}
      end
    end
  end 

  def show
    begin
      @student = Student.find(params[:id])
      respond_to do |format|
        format.json {render json: {student: @student}, status: :ok}
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
    @student = Student.new
  end 

  def edit
    @student = Student.find(params[:id])
  end

  def create
    begin
      @student = Student.new(student_params)
      @school = School.find_by_id(params[:school_id])
      @classroom = Classroom.find_by_id(params[:classroom_id])
      @subject = Subject.find_by_id(params[:subject_ids])
      @teacher = Teacher.find_by_id(params[:teacher_ids])
      if @student.save
        respond_to do |format|
          format.json {render json: {student: @student}, status: :ok}
          format.html {redirect_to :back}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @student.errors}, status: :unprocessable_entity}
          format.html {render html: {message: @student.errors.messages}, status: :unprocessable_entity}
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
      @student = Student.find(params[:id]) 
      if @student.update(student_params)  
        respond_to do |format|
          format.json {render json: {student: @student}, status: :ok}
          format.html {redirect_to @student}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @student.errors}, status: :unprocessable_entity}
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
      @student = Student.find(params[:id])
      if @student.destroy
        respond_to do |format|
          format.json {render json: {message: 'Successfully deleted'}, status: :ok}
          format.html {redirect_to :back}
        end  
      else
        respond_to do |format|
          format.json {render json: {error: @student.errors}, status: :unprocessable_entity}
          format.html {redirect_to @student}
        end  
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found}
        format.html {redirect_to @student}
      end
    end
  end

  private
    def student_params
      params.require(:student).permit(:name, :address, :phone_no, :percentage, :school_id, :classroom_id, :subject_ids, :teacher_ids)
    end
end