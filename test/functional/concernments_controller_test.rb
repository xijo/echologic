require 'test_helper'

class ConcernmentsControllerTest < ActionController::TestCase
  def setup
    @controller = ConcernmentsController.new
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:concernments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create concernment" do
    assert_difference('Concernment.count') do
      post :create, :concernment => { }
    end

    assert_redirected_to concernment_path(assigns(:concernment))
  end

  test "should show concernment" do
    get :show, :id => concernments(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => concernments(:one).to_param
    assert_response :success
  end

  test "should update concernment" do
    put :update, :id => concernments(:one).to_param, :concernment => { }
    assert_redirected_to concernment_path(assigns(:concernment))
  end

  test "should destroy concernment" do
    assert_difference('Concernment.count', -1) do
      delete :destroy, :id => concernments(:one).to_param
    end

    assert_redirected_to concernments_path
  end
end
