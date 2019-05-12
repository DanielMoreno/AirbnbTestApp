require 'test_helper'

class BookingsControllerTest < ActionDispatch::IntegrationTest
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

  room = user1.rooms.new title: 'test room', home_type: 'House', room_type: 'Private room', accommodates: 1, city: 'Tokyo', price: 75
  room.save!

  booking = room.bookings.new start_date: '2019-6-5', end_date: '2019-6-15', price: 75, total: 750, 'user': user2
  booking.save!

  test "Test - Index" do
    get bookings_path
    assert true
  end

  test "Test - Show" do
    get room_booking_path(id: booking.id, room_id: booking.room.id)
    assert true
  end

  test "Test - Room Index" do
    get room_bookings_path(room_id: booking.room.id)
    assert true
  end
end
