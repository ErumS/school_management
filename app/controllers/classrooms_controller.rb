class ClassroomsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @classrooms = Classroom.all
    if @classrooms
      respond_to do |format|
        format.json {render json: {classrooms: @classrooms}, status: :ok }
        format.html
      end
    else
      respond_to do |format| 
        format.json {render json: {error: @classrooms.errors}, status: :not_found}
        format.html {render html: {error: @classrooms.errors.messages}, status: :not_found}
      end
    end
  end 

  def show
    begin
      @classroom = Classroom.find(params[:id])
      respond_to do |format|
        format.json {render json: {classroom: @classroom}, status: :ok}
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
    @classroom = Classroom.new
  end 

  def edit
    @classroom = Classroom.find(params[:id])
  end

  def create
    begin
      @classroom = Classroom.new(classroom_params)
      @school = School.find_by_id(params[:school_id])
      if @classroom.save
        respond_to do |format|
          format.json {render json: {classroom: @classroom}, status: :ok}
          format.html {redirect_to :back}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @classroom.errors}, status: :unprocessable_entity}
          format.html {render html: {error: @classroom.errors.messages}, status: :unprocessable_entity}
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
      @classroom = Classroom.find(params[:id]) 
      if @classroom.update(classroom_params)  
        respond_to do |format|
          format.json {render json: {classroom: @classroom}, status: :ok}
          format.html {redirect_to @classroom}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @classroom.errors}, status: :unprocessable_entity}
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
      @classroom = Classroom.find(params[:id])
      if @classroom.destroy
        respond_to do |format|
          format.json {render json: {message: 'Successfully deleted'}, status: :ok}
          format.html {redirect_to :back}
        end  
      else
        respond_to do |format|
          format.json {render json: {error: @classroom.errors}, status: :unprocessable_entity}
          format.html {redirect_to @classroom}
        end  
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found}
        format.html {redirect_to @classroom}
      end
    end
  end

  private
    def classroom_params
      params.require(:classroom).permit(:standard, :no_of_students, :school_id)
    end
end