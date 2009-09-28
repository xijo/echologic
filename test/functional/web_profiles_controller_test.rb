require 'test_helper'

class WebProfilesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:web_profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create web_profile" do
    assert_difference('WebProfile.count') do
      post :create, :web_profile => { }
    end

    assert_redirected_to web_profile_path(assigns(:web_profile))
  end

  test "should show web_profile" do
    get :show, :id => web_profiles(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => web_profiles(:one).to_param
    assert_response :success
  end

  test "should update web_profile" do
    put :update, :id => web_profiles(:one).to_param, :web_profile => { }
    assert_redirected_to web_profile_path(assigns(:web_profile))
  end

  test "should destroy web_profile" do
    assert_difference('WebProfile.count', -1) do
      delete :destroy, :id => web_profiles(:one).to_param
    end

    assert_redirected_to web_profiles_path
  end
end
