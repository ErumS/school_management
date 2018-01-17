class SchoolsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @schools = School.all
    if @schools
      respond_to do |format|
        format.json {render json: {schools: @schools}, status: :ok }
        format.html
      end
    else
      respond_to do |format| 
        format.json {render json: {error: @schools.errors}, status: :not_found}
        format.html
      end
    end
  end 

  def show
    begin
      @school = School.find(params[:id])
      respond_to do |format|
        format.json {render json: {school: @school}, status: :ok}
        format.html
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found} 
        format.html
      end
    end
  end

  def new
    @school = School.new
  end 

  def edit
    @school = School.find(params[:id])
  end

  def create
    @school = School.new(school_params)
    if @school.save
      respond_to do |format|
        format.json {render json: {school: @school}, status: :ok}
        format.html {redirect_to @school}
      end
    else
      respond_to do |format|
        format.json {render json: {error: @school.errors}, status: :unprocessable_entity}
        format.html {render 'new'}
      end
    end
  end 

  def update
    begin
      @school = School.find(params[:id]) 
      if @school.update(school_params)  
        respond_to do |format|
          format.html {redirect_to schools_path}
          format.json {render json: {school: @school}, status: :ok}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @school.errors}, status: :unprocessable_entity}
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
      @school = School.find(params[:id])
      if @school.destroy
        respond_to do |format|
          format.json {render json: {message: 'Successfully deleted'}, status: :ok}
          format.html {redirect_to schools_path}
        end  
      else
        respond_to do |format|
          format.json {render json: {error: @school.errors}, status: :unprocessable_entity}
          format.html {redirect_to @school}
        end  
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found}
        format.html {redirect_to @school}
      end
    end
  end

  private
    def school_params
      params.require(:school).permit(:name, :address, :phone_no)
    end
end