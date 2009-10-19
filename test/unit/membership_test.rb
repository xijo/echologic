require 'test_helper'

class MembershipTest < ActiveSupport::TestCase

  # Memberships mustn't be saved empty.
  def test_no_empty_saving
    m = Membership.new
    assert !m.save
  end

  # Memberships have to belong to a user.
  def test_presence_of_user
    @m = memberships(:joe_greenpeace)
    assert_kind_of User, @m.user
  end

end
