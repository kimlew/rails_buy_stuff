ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login_as(user)
    session[:user_id] = users(user).id
  end
  
  def logout
    session.delete :user_id
  end
  
  # This test_helper globally addresses invalidation of most functional tests
  # due to addition of skip_before_action :authorize, only: [:new, :create] 
  # in the OrdersController. Calls login_as() - ONLY if session is defined.
  # Prevents login execution in tests that do NOT involve a controller.
  def setup
    login_as :one if defined? session
  end

end
