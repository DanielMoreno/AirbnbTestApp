# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

testOwner = User.create( email: 'TestOwner@test.com', password: 'qweqwe123', first_name: 'Testing', last_name: 'Owner' )
bookingTester = User.create( email: 'BookingTester@test.com', password: 'qweqwe123', first_name: 'Booking', last_name: 'Tester' )

bestRoom = testOwner.rooms.create title: 'Best Room in Boston', home_type: 'House', room_type: 'Private room', accommodates: 1, 
  city: 'Boston', price: 400, is_published: true, contract_agreement: true
worstRoom = testOwner.rooms.create title: 'Worst Room in Boston', home_type: 'House', room_type: 'Private room', accommodates: 1, 
  city: 'Boston', price: 25,  is_published: true, contract_agreement: true
testOwner.rooms.create title: 'Unlisted room in Boston', home_type: 'House', room_type: 'Private room', accommodates: 1, 
  city: 'Boston', price: 400, is_published: false, contract_agreement: false


worstRoom.bookings.create start_date: '2019-6-1', end_date: '2019-6-11', price: 25, 'user': bookingTester, confirmation_status: 'accepted'
bestRoom.bookings.create start_date: '2019-6-19', end_date: '2019-6-29', price: 400, 'user': bookingTester, confirmation_status: 'accepted'
bestRoom.bookings.create start_date: '2019-7-1', end_date: '2019-7-5', price: 400, 'user': bookingTester, confirmation_status: 'pending'
bestRoom.bookings.create start_date: '2019-7-4', end_date: '2019-7-10', price: 400, 'user': bookingTester, confirmation_status: 'pending'
worstRoom.bookings.create start_date: '2019-7-15', end_date: '2019-7-20', price: 400, 'user': bookingTester, confirmation_status: 'pending'
worstRoom.bookings.create start_date: '2019-7-21', end_date: '2019-7-25', price: 400, 'user': bookingTester, confirmation_status: 'pending'
