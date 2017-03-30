require 'test_helper'

class UserActivitiesControllerTest < ActionController::TestCase
  setup do
    @user_activity = user_activities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_activities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_activity" do
    assert_difference('UserActivity.count') do
      post :create, user_activity: { happened_at: @user_activity.happened_at, private_details: @user_activity.private_details, public_details: @user_activity.public_details, user_id: @user_activity.user_id }
    end

    assert_redirected_to user_activity_path(assigns(:user_activity))
  end

  test "should show user_activity" do
    get :show, id: @user_activity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_activity
    assert_response :success
  end

  test "should update user_activity" do
    patch :update, id: @user_activity, user_activity: { happened_at: @user_activity.happened_at, private_details: @user_activity.private_details, public_details: @user_activity.public_details, user_id: @user_activity.user_id }
    assert_redirected_to user_activity_path(assigns(:user_activity))
  end

  test "should destroy user_activity" do
    assert_difference('UserActivity.count', -1) do
      delete :destroy, id: @user_activity
    end

    assert_redirected_to user_activities_path
  end
end
