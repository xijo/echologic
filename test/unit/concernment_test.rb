require 'test_helper'
# TODO order of fixture loading must not be alphabetical.

class ConcernmentTest < ActiveSupport::TestCase

  # Concernment may not be saved empty.
  def test_no_empty_saving
    @c = Concernment.new
    assert !@c.save, 'Do not save empty concernment!'
  end

  # Concernments have to have a user.
  def test_user_presence
    @c = concernments(:joe_energy)
    assert_kind_of User, @c.user
  end

  # Concernments have to have a tag.
  def test_tag_presence
    @c = concernments(:joe_energy)
    assert_kind_of Tag, @c.tag
  end

  # 1. Concernments must have the sorts method present.
  # 2. Concernments have four sorts.
  # 3. Concernment sorts have keys and values.
  # 4. Key has to be a Number.
  # 5. Value has to be a string.
  def test_sorts
    assert_kind_of Array, Concernment.sorts
    sorts = Concernment.sorts
    assert_equal sorts.size, 4
    assert_kind_of Array, sorts.first
    assert_equal sorts.first.size, 2
    assert_kind_of Integer, sorts.first.first
    assert_kind_of String, sorts.first.second
  end

end
