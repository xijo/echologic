require 'test_helper'

class TagTest < ActiveSupport::TestCase

  # Tags can not be created without a value.
  def test_presence_of_value
    assert !Tag.new.save
  end

end
