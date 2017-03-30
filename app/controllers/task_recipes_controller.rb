class TaskRecipesController < ApplicationController
  before_action :set_task_recipe, only: [:show, :edit, :update, :destroy]

  # GET /task_recipes
  # GET /task_recipes.json
  def index
    @task_recipes = TaskRecipe.all
  end

  # GET /task_recipes/1
  # GET /task_recipes/1.json
  def show
  end

  # GET /task_recipes/new
  def new
    @task_recipe = TaskRecipe.new
  end

  # GET /task_recipes/1/edit
  def edit
  end

  # POST /task_recipes
  # POST /task_recipes.json
  def create
    @task_recipe = TaskRecipe.new(task_recipe_params)

    respond_to do |format|
      if @task_recipe.save
        format.html { redirect_to @task_recipe, notice: 'Task recipe was successfully created.' }
        format.json { render :show, status: :created, location: @task_recipe }
      else
        format.html { render :new }
        format.json { render json: @task_recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_recipes/1
  # PATCH/PUT /task_recipes/1.json
  def update
    respond_to do |format|
      if @task_recipe.update(task_recipe_params)
        format.html { redirect_to @task_recipe, notice: 'Task recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_recipe }
      else
        format.html { render :edit }
        format.json { render json: @task_recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_recipes/1
  # DELETE /task_recipes/1.json
  def destroy
    @task_recipe.destroy
    respond_to do |format|
      format.html { redirect_to task_recipes_url, notice: 'Task recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_recipe
      @task_recipe = TaskRecipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_recipe_params
      params.require(:task_recipe).permit(:event, :description, :days_before_due, :category_name)
    end
end
