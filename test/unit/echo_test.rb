require File.join(File.dirname(__FILE__), '..', 'test_helper')

class EchoTest < ActiveSupport::TestCase
  def setup
    @echoable = Statement.first
    # make sure we don't have a echo already
    @echoable.update_attributes!(:echo_id => nil)
    @user = User.first
    
    assert( ! @user.visited?(@echoable))
    assert( ! @user.supported?(@echoable))
  end
  
  def test_should_create_echo
    assert(echo = @echoable.find_or_create_echo, "Echo wasn't created")
    assert( ! echo.new_record?, "Echo didn't get saved")
  end
  
  def test_should_state_visited
    @user.visited!(@echoable)
    assert(@user.visited?(@echoable))
  end
  
  def test_should_state_supported
    @user.supported!(@echoable)
    assert(@user.supported?(@echoable))
  end
end
