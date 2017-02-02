require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal "Buy Stuff Order Confirmation", mail.subject
    assert_equal ["nora@example.org"], mail.to
    assert_equal ["buy_stuff@example.com"], mail.from
    assert_match /1 x Tea/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "Buy Stuff Order Shipped", mail.subject
    assert_equal ["nora@example.org"], mail.to
    assert_equal ["buy_stuff@example.com"], mail.from
    assert_match /<td>1&nbsp;&times;&nbsp;<\/td>\s*<td>Tea<\/td>/, mail.body.encoded
  end

end
