class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    if params[:assignee].present?
      @tasks = Task.where(assigned_to: params[:assignee])
    else
      @tasks = Task.all
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html do
          flash[:success] = 'Task was successfully created.'
          redirect_to @task
        end
        format.json { render :show, status: :created, location: @task }
      else
        format.html do
          flash[:danger] = 'Task could not be created.'
          render :new
        end
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html do
          flash[:success] = 'Task was successfully updated.'
          redirect_to @task
        end
        format.json { render :show, status: :ok, location: @task }
      else
        format.html do
          flash[:danger] = 'Task could not be updated.'
          render :edit
        end
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html do
        flash[:success] = 'Task was successfully destroyed.'
        redirect_to tasks_url
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:description, :assigned_to, :due_at)
    end
end
