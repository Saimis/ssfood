require 'test_helper'

class Admin::OrdersControllerTest < ActionController::TestCase
  setup do
    @archyfe = archyves(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:archyves)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create archyfe" do
    assert_difference('Archyve.count') do
      post :create, archyfe: { caller: @archyfe.caller, date: @archyfe.date, gc: @archyfe.gc, payer: @archyfe.payer, restaurant_id: @archyfe.restaurant_id }
    end

    assert_redirected_to archyfe_path(assigns(:archyfe))
  end

  test "should show archyfe" do
    get :show, id: @archyfe
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @archyfe
    assert_response :success
  end

  test "should update archyfe" do
    patch :update, id: @archyfe, archyfe: { caller: @archyfe.caller, date: @archyfe.date, gc: @archyfe.gc, payer: @archyfe.payer, restaurant_id: @archyfe.restaurant_id }
    assert_redirected_to archyfe_path(assigns(:archyfe))
  end

  test "should destroy archyfe" do
    assert_difference('Archyve.count', -1) do
      delete :destroy, id: @archyfe
    end

    assert_redirected_to archyves_path
  end
end
