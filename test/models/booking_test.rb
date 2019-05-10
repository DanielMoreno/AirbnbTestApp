require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  ## Create or set a user for testing
  user1 = User.first
  if(!user1)
  	user1 = User.new email: 'jon@jon.com', password: 'qweqwe123', first_name: 'Bob', last_name: 'Dole'
  	user1.save!
  end
    ## Create or set a user for testing
  user2 = User.first
  if(!user2)
  	user2 = User.new email: 'joe@joe.com', password: 'qweqwe123', first_name: 'Joe', last_name: 'Joe'
  	user2.save!
  end

  room = user1.rooms.new title: 'test room', home_type: 'House', room_type: 'Private room', accommodates: 1, city: 'Tokyo', price: 75
  room.save!
  freeRoom = user1.rooms.new title: 'free test room', home_type: 'House', room_type: 'Private room', accommodates: 1, city: 'Tokyo', price: 0
  freeRoom.save!

  test "Test Booking Creation" do
    booking = room.bookings.new start_date: '2019-6-5', end_date: '2019-6-15', price: 75, total: 750, 'user': user2
    assert booking.save, "Basic booking was not saved successfully"
  end


   ## Required parameter checking
  test "Test Booking - Room" do
    booking = user2.bookings.new start_date: '2019-6-5', end_date: '2019-6-15', price: 75, total: 750
    assert_not booking.save, "Created booking did not have a room"
  end
  test "Test Booking - User" do
    booking = room.bookings.new start_date: '2019-6-5', end_date: '2019-6-15', price: 75, total: 750
    assert_not booking.save, "Created booking did not have a user"
  end
  test "Test Booking - Start Date" do
    booking = room.bookings.new start_date: '', end_date: '2019-6-15', price: 75, total: 750, 'user': user2
    assert_not booking.save, "Created booking did not have a start_date"
  end
  test "Test Booking - End Date" do
    booking = room.bookings.new start_date: '2019-6-5', end_date: '', price: 75, total: 750, 'user': user2
    assert_not booking.save, "Created booking did not have a end_date"
  end
  test "Test Booking - Price" do
    booking = room.bookings.new start_date: '2019-6-5', end_date: '2019-6-15', price: nil, total: 750, 'user': user2
    assert_not booking.save, "Created booking did not have a price"
  end
  test "Test Booking - Total" do
    booking = room.bookings.new start_date: '2019-6-5', end_date: '2019-6-15', price: 75, total: nil, 'user': user2
    assert_not booking.save, "Created booking did not have a total"
  end

  ## Customized Validation Logic Testing
  test "Test Booking - Free Room" do
    booking = freeRoom.bookings.new start_date: '2019-6-5', end_date: '2019-6-15', price: 0, total: 0, 'user': user2
    assert booking.save, "Free room booking was not saved successfully"
  end
  test "Test Booking - Start Date after End Date" do
    booking = freeRoom.bookings.new start_date: '2019-6-15', end_date: '2019-6-5', price: 0, total: 0, 'user': user2
    assert_not booking.save, "Created booking with the start date after the end date"
  end
  test "Test Booking - Start Date same as End Date" do
    booking = freeRoom.bookings.new start_date: '2019-6-5', end_date: '2019-6-5', price: 0, total: 0, 'user': user2
    assert_not booking.save, "Created booking with the start date same as the end date"
  end
  test "Test Booking - Different Price" do
    booking = room.bookings.new start_date: '2019-6-5', end_date: '2019-6-15', price: 40, total: 400, 'user': user2
    assert_not booking.save, "Created booking with the start date same as the end date"
  end
  test "Test Booking - Incorrect Total" do
    booking = room.bookings.new start_date: '2019-6-5', end_date: '2019-6-15', price: 75, total: 500, 'user': user2
    assert_not booking.save, "Created booking with the start date same as the end date"
  end
  test "Test Booking - Availability Same Date" do
    booking1 = room.bookings.new start_date: '2019-6-5', end_date: '2019-6-15', price: 75, total: 750, 'user': user2
    booking1.save!
    booking2 = room.bookings.new start_date: '2019-6-5', end_date: '2019-6-15', price: 75, total: 750, 'user': user2
    assert_not booking2.save, "Created booking an existing booking at the same time"
  end
  test "Test Booking - Availability Start Overlap" do
    booking1 = room.bookings.new start_date: '2019-6-11', end_date: '2019-6-21', price: 75, total: 750, 'user': user2
    booking1.save!
    booking2 = room.bookings.new start_date: '2019-6-5', end_date: '2019-6-15', price: 75, total: 750, 'user': user2
    assert_not booking2.save, "Created booking an existing booking at the same time"
  end
  test "Test Booking - Availability End Overlap" do
    booking1 = room.bookings.new start_date: '2019-6-1', end_date: '2019-6-11', price: 75, total: 750, 'user': user2
    booking1.save!
    booking2 = room.bookings.new start_date: '2019-6-5', end_date: '2019-6-15', price: 75, total: 750, 'user': user2
    assert_not booking2.save, "Created booking an existing booking at the same time"
  end
    test "Test Booking - Availability All Overlap" do
    booking1 = room.bookings.new start_date: '2019-6-1', end_date: '2019-6-21', price: 75, total: 1500, 'user': user2
    booking1.save!
    booking2 = room.bookings.new start_date: '2019-6-5', end_date: '2019-6-15', price: 75, total: 750, 'user': user2
    assert_not booking2.save, "Created booking an existing booking at the same time"
  end
end
