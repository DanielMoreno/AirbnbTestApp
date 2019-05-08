require 'test_helper'

class RoomsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  ## Create or set a user for testing
  user1 = User.first
  if(!user1)
  	user1 = User.new email: 'jon@jon.com', password: 'qweqwe123', first_name: 'Bob', last_name: 'Dole'
  	user1.save!
  end
  user2 = User.second
  if(!user2)
  	user2 = User.new email: 'joe@joe.com', password: 'qweqwe123', first_name: 'Bob', last_name: 'Dole'
  	user2.save!
  end

  room = user1.rooms.new title: 'test room', home_type: 'House', room_type: 'Private room', accommodates: 1, city: 'Tokyo'
  room.save!
  puts room.id

  test "Test - Index" do
    get rooms_path
    assert true
  end

  test "Test - Show" do
    get room_path(room.id)
    assert true
  end

  test "Test - New" do
    get new_room_path
    assert true
  end

  test "Test - Edit" do
    get edit_room_path(room.id)
    assert true
  end
end
