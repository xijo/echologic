require 'test_helper'

class InteresstedPeopleControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:interessted_people)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create interessted_person" do
    assert_difference('InteresstedPerson.count') do
      post :create, :interessted_person => { }
    end

    assert_redirected_to interessted_person_path(assigns(:interessted_person))
  end

  test "should show interessted_person" do
    get :show, :id => interessted_people(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => interessted_people(:one).to_param
    assert_response :success
  end

  test "should update interessted_person" do
    put :update, :id => interessted_people(:one).to_param, :interessted_person => { }
    assert_redirected_to interessted_person_path(assigns(:interessted_person))
  end

  test "should destroy interessted_person" do
    assert_difference('InteresstedPerson.count', -1) do
      delete :destroy, :id => interessted_people(:one).to_param
    end

    assert_redirected_to interessted_people_path
  end
end
