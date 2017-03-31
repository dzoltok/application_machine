class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :edit, :update, :destroy, :fire_event]

  # GET /applications
  # GET /applications.json
  def index
    @applications = Application.all
  end

  # GET /applications/1
  # GET /applications/1.json
  def show
  end

  # GET /applications/new
  def new
    @application = Application.new
  end

  # GET /applications/1/edit
  def edit
  end

  # POST /applications
  # POST /applications.json
  def create
    @application = Application.new(application_params)

    respond_to do |format|
      if @application.save
        format.html { redirect_to @application, notice: 'Application was successfully created.' }
        format.json { render :show, status: :created, location: @application }
      else
        format.html { render :new }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applications/1
  # PATCH/PUT /applications/1.json
  def update
    respond_to do |format|
      if @application.update(application_params)
        format.html { redirect_to @application, notice: 'Application was successfully updated.' }
        format.json { render :show, status: :ok, location: @application }
      else
        format.html { render :edit }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applications/1
  # DELETE /applications/1.json
  def destroy
    @application.destroy
    respond_to do |format|
      format.html { redirect_to applications_url, notice: 'Application was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /applications/1/fire_event
  # POST /applications/1/fire_event.json
  def fire_event
    event = fire_event_params[:event]
    respond_to do |format|
      if @application.aasm.events.map(&:name).include? event.to_sym
        @application.send("#{event}!")
        format.html {
          flash[:success] = 'Application state has been updated.'
          redirect_to @application.user
        }
        format.json { render :show, status: :ok, location: @application }
      else
        format.html {
          flash[:danger] = 'Application state could not be changed.'
          redirect_to @application.user
        }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_params
      params.require(:application).permit(:goal, :user_id)
    end

    def fire_event_params
      params.require(:application).permit(:event)
    end
end
