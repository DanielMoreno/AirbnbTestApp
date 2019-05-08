require 'test_helper'

class UserTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers
  
  test "Test User Creation" do
    user = User.new email: 'jon@jon.com', password: 'qweqwe123', first_name: 'Bob', last_name: 'Dole'
    assert user.save, "Basic user was not saved successfully"
  end

  test "Test User Email Register" do
    user = User.new email: '', password: 'qweqwe123', first_name: 'Bob', last_name: 'Dole'
	  assert_not user.save, "Saved the user without a email"
  end

  test "Test User Password Register" do
    user = User.new email: 'jon@jon.com', password: '', first_name: 'Bob', last_name: 'Dole'
	  assert_not user.save, "Saved the user without a validpassword"
  end

    test "Test first_name Register" do
    user = User.new email: 'jon@jon.com', password: 'qweqwe123', first_name: '', last_name: 'Dole'
    assert_not user.save, "Saved the user without a first name"
  end

    test "Test last_name Register" do
    user = User.new email: 'jon@jon.com', password: 'qweqwe123', first_name: 'Bob', last_name: ''
    assert_not user.save, "Saved the user without a last name"
  end

  test "Test Registeration and Login" do
    user = User.new email: 'jon@jon.com', password: 'qweqwe123', first_name: 'Bob', last_name: 'Dole'
    user.save!
    sign_in( user )
    sign_out(user)
    assert true
  end
end
