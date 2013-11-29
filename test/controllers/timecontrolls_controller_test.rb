require 'test_helper'

class TimecontrollsControllerTest < ActionController::TestCase
  setup do
    @timecontroll = timecontrolls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:timecontrolls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create timecontroll" do
    assert_difference('Timecontroll.count') do
      post :create, timecontroll: { end: @timecontroll.end, gap: @timecontroll.gap, start: @timecontroll.start }
    end

    assert_redirected_to timecontroll_path(assigns(:timecontroll))
  end

  test "should show timecontroll" do
    get :show, id: @timecontroll
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @timecontroll
    assert_response :success
  end

  test "should update timecontroll" do
    patch :update, id: @timecontroll, timecontroll: { end: @timecontroll.end, gap: @timecontroll.gap, start: @timecontroll.start }
    assert_redirected_to timecontroll_path(assigns(:timecontroll))
  end

  test "should destroy timecontroll" do
    assert_difference('Timecontroll.count', -1) do
      delete :destroy, id: @timecontroll
    end

    assert_redirected_to timecontrolls_path
  end
end
