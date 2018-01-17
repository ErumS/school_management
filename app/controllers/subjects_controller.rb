class SubjectsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @subjects = Subject.all
    if @subjects
      respond_to do |format|
        format.json {render json: {subjects: @subjects}, status: :ok }
        format.html
      end
    else
      respond_to do |format| 
        format.json {render json: {error: @subjects.errors}, status: :not_found}
        format.html {render html: {message: @subjects.errors.messages}, status: :not_found}
      end
    end
  end 

  def show
    begin
      @subject = Subject.find(params[:id])
      respond_to do |format|
        format.json {render json: {subject: @subject}, status: :ok}
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
    @subject = Subject.new
  end 

  def edit
    @subject = Subject.find(params[:id])
  end

  def create
    begin
      @subject = Subject.new(subject_params)
      @school = School.find_by_id(params[:school_id])
      @student = Student.find_by_id(params[:student_ids])
      if @subject.save
        respond_to do |format|
          format.json {render json: {subject: @subject}, status: :ok}
          format.html {redirect_to :back}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @subject.errors}, status: :unprocessable_entity}
          format.html {render html: {message: @subject.errors.messages}, status: :unprocessable_entity}
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
      @subject = Subject.find(params[:id]) 
      if @subject.update(subject_params)  
        respond_to do |format|
          format.json {render json: {subject: @subject}, status: :ok}
          format.html {redirect_to @subject}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @subject.errors}, status: :unprocessable_entity}
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
      @subject = Subject.find(params[:id])
      if @subject.destroy
        respond_to do |format|
          format.json {render json: {message: 'Successfully deleted'}, status: :ok}
          format.html {redirect_to :back}
        end  
      else
        respond_to do |format|
          format.json {render json: {error: @subject.errors}, status: :unprocessable_entity}
          format.html {redirect_to @subject}
        end  
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found}
        format.html {redirect_to @subject}
      end
    end
  end

  private
    def subject_params
      params.require(:subject).permit(:name, :subject_duration, :school_id, :student_ids)
    end
end