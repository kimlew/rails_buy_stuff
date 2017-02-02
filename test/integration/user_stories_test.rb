require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products
  
  # User goes to store index page. 
  # User selects a product, adding it to their cart. 
  # User checks out, by first, filling in their details on the checkout form. 
  # When User clicks submits with Place Order button:
  # - an order is created in the database containing their information
  # - along with a single line item, corresp. to product user added to cart
  # Once order has been received, email sent to User confirming their purchase. 
  
  test "buying a product" do
    LineItem.delete_all
    Order.delete_all

    tea = products(:tea)
  
    get "/" 
    assert_response :success 
    assert_template "index" 

    # Invoke action with xml_http_request.
    xml_http_request :post, '/line_items', product_id: tea.id
    assert_response :success
  
    # Check that cart now contains the requested product.
    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal tea, cart.line_items[0].product
  
    # Get the new orders so user can check out.
    get "/orders/new"
    assert_response :success
    assert_template "new"

    # Post form data to save_order action.
    # Verify user redirected to index.
    # Check that the cart is now empty.
    post_via_redirect "/orders",
                      order: { name:  "Dave Thomas",
                      address:        "123 The Street",
                      email:          "dave@example.com",
                      pay_type:       "Check" }

    assert_response :success
    assert_template "index"
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size

    # Verify orders table that was cleared out at start of test, contains 
    # new order.
    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]

    assert_equal "Dave Thomas", order.name
    assert_equal "123 The Street", order.address
    assert_equal "dave@example.com", order.email
    assert_equal "Check", order.pay_type

    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal tea, line_item.product
  
    # Verify mail is correctly addressed.
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"], mail.to
    assert_equal 'Sydney Simian <buy_stuff@example.com>', mail[:from].value
    assert_equal "Buy Stuff Order Confirmation", mail.subject
  end # End of integration test: "buying a product" do
  
end


