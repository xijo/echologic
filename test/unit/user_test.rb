require 'test_helper'

class UserTest < ActiveSupport::TestCase

  # 1. Users should have associations to:
  #     - Web profiles
  #     - Concernments
  #     - Tags
  #     - Memberships
  def test_associations
    @user = users(:joe)
    assert_not_nil @user.web_profiles
    assert_not_nil @user.concernments
    assert_not_nil @user.tags
    assert_not_nil @user.memberships
  end

  # 1. Roles can be assigned to users.
  # 2. The users roles may be accessed.
  def test_role_associations
    @user = users(:joe)
    assert_respond_to @user, :has_role?
    assert @user.has_role!(:admin)
  end

  # 1. Users must not be saved empty.
  def test_no_empty_saving
    assert !User.new.save
  end

end
