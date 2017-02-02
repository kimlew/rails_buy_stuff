require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  # Remember: assertions based on test data in fixtures, products.yml
  test "should get index" do
    get :index
    assert_response :success
    
    assert_select '#columns #side a', minimum: 4 
    assert_select '#main .entry', 3 
    assert_select 'h3', 'Tea' 
    assert_select '.price', /\$[,\d]+\.\d\d/
  end

end
