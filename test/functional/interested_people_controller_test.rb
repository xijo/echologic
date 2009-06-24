require 'test_helper'

class InterestedPeopleControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:interested_people)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create interested_person" do
    assert_difference('InterestedPerson.count') do
      post :create, :interested_person => { }
    end

    assert_redirected_to interested_person_path(assigns(:interested_person))
  end

  test "should show interested_person" do
    get :show, :id => interested_people(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => interested_people(:one).to_param
    assert_response :success
  end

  test "should update interested_person" do
    put :update, :id => interested_people(:one).to_param, :interested_person => { }
    assert_redirected_to interested_person_path(assigns(:interested_person))
  end

  test "should destroy interested_person" do
    assert_difference('InterestedPerson.count', -1) do
      delete :destroy, :id => interested_people(:one).to_param
    end

    assert_redirected_to interested_people_path
  end
end
