require 'test_helper'

class WebProfileTest < ActiveSupport::TestCase
  
  # Web profiles mustn't be saved empty.
  def test_no_empty_saving
    w = WebProfile.new
    assert !w.save
  end

  # Web profile model has to provide which profiles are available.
  def test_sorts
    assert_kind_of Array, WebProfile.sorts
  end

  # Web profiles has to belong to a user.
  def test_presence_of_user
    assert_kind_of User, web_profiles(:joe_twitter).user
  end

end
