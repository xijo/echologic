require 'test_helper'

class FeedbackMailerTest < ActionMailer::TestCase
  test "feedback" do
    @expected.subject = 'FeedbackMailer#feedback'
    @expected.body    = read_fixture('feedback')
    @expected.date    = Time.now

    assert_equal @expected.encoded, FeedbackMailer.create_feedback(@expected.date).encoded
    mail = FeedbackMailer.deliver_feedback
  end

end
