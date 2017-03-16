require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "invite_submittion" do
    mail = UserMailer.invite_submittion
    assert_equal "Invite submittion", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
