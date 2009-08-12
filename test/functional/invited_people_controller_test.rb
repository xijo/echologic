require 'test_helper'

class InvitedPeopleControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:invited_people)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create invited_person" do
    assert_difference('InvitedPerson.count') do
      post :create, :invited_person => { }
    end

    assert_redirected_to invited_person_path(assigns(:invited_person))
  end

  test "should show invited_person" do
    get :show, :id => invited_people(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => invited_people(:one).to_param
    assert_response :success
  end

  test "should update invited_person" do
    put :update, :id => invited_people(:one).to_param, :invited_person => { }
    assert_redirected_to invited_person_path(assigns(:invited_person))
  end

  test "should destroy invited_person" do
    assert_difference('InvitedPerson.count', -1) do
      delete :destroy, :id => invited_people(:one).to_param
    end

    assert_redirected_to invited_people_path
  end
end
