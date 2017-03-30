require 'test_helper'

class TaskRecipesControllerTest < ActionController::TestCase
  setup do
    @task_recipe = task_recipes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:task_recipes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create task_recipe" do
    assert_difference('TaskRecipe.count') do
      post :create, task_recipe: { assigned_to: @task_recipe.assigned_to, description: @task_recipe.description, due_at: @task_recipe.due_at, event: @task_recipe.event }
    end

    assert_redirected_to task_recipe_path(assigns(:task_recipe))
  end

  test "should show task_recipe" do
    get :show, id: @task_recipe
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @task_recipe
    assert_response :success
  end

  test "should update task_recipe" do
    patch :update, id: @task_recipe, task_recipe: { assigned_to: @task_recipe.assigned_to, description: @task_recipe.description, due_at: @task_recipe.due_at, event: @task_recipe.event }
    assert_redirected_to task_recipe_path(assigns(:task_recipe))
  end

  test "should destroy task_recipe" do
    assert_difference('TaskRecipe.count', -1) do
      delete :destroy, id: @task_recipe
    end

    assert_redirected_to task_recipes_path
  end
end
