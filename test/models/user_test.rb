require 'test_helper'

class UserTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers
  test "Test Registeration and Login" do
    user = User.new email: 'jon@jon.com', password: 'qweqwe123'
	user.save!
	sign_in( user )
    sign_out(user)
    assert true
  end
  test "Test User Email Register" do
    user = User.new email: '', password: 'qweqwe123'
	assert_not user.save, "Saved the user without a email"
  end
  test "Rest User User Password Register" do
    user = User.new email: 'jon@jon.com', password: ''
	assert_not user.save, "Saved the user without a validpassword"
  end

end
