require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  ## Create or set a user for testing
  user = User.first
  if(!user)
  	user = User.new email: 'jon@jon.com', password: 'qweqwe123', first_name: 'Bob', last_name: 'Dole'
  	user.save!
  end

  test "Test Room Creation" do
    room = user.rooms.new title: 'test room', home_type: 'House', room_type: 'Private room', accommodates: 1, city: 'Tokyo', price: 75
    assert room.save, "Basic room was not saved successfully"
  end

  test "Test User - Belongs To Association" do
    room = Room.new title: 'test room', home_type: 'House', room_type: 'Private room', accommodates: 1, city: 'Tokyo', price: 75
    assert_not room.save, "Created room was associated with a User"
  end

  test "Test Room - Title" do
    room = user.rooms.new title: '', home_type: 'House', room_type: 'Private room', accommodates: 1, city: 'Tokyo', price: 75
    assert_not room.save, "Created room did not have a title"
  end

  test "Test Room - Home Type" do
    room = user.rooms.new title: 'test room', home_type: '', room_type: 'Private room', accommodates: 1, city: 'Tokyo', price: 75
    assert_not room.save, "Created room did not have a home_type"
  end

  test "Test Room - Room Type" do
    room = user.rooms.new title: 'test room', home_type: 'House', room_type: '', accommodates: 1, city: 'Tokyo', price: 75
    assert_not room.save, "Created room did not have a room_type"
  end

  test "Test Room - Accommodates" do
    room = user.rooms.new title: 'test room', home_type: 'House', room_type: 'Private room', accommodates: nil, city: 'Tokyo', price: 75
    assert_not room.save, "Created room did not have a accommodates"
  end
  
  test "Test Room - City" do
    room = user.rooms.new title: 'test room', home_type: 'House', room_type: 'Private room', accommodates: 1, city: '', price: 75
    assert_not room.save, "Created room did not have a city"
  end

  test "Test Room - Price" do
    room = user.rooms.new title: 'test room', home_type: 'House', room_type: 'Private room', accommodates: 1, city: 'Tokyo', price: nil
    assert_not room.save, "Created room did not have a price"
  end

  test "Test Room - Published without contract agreement" do
    room = user.rooms.new title: 'test room', home_type: 'House', room_type: 'Private room', accommodates: 1, city: 'Tokyo', price: 75,
      is_published: true, contract_agreement: false
    assert_not room.save, "Published room without accepting the contract agreement"
  end

  test "Test Room - Contract agreement retraction on published room" do
    room = user.rooms.new title: 'test room', home_type: 'House', room_type: 'Private room', accommodates: 1, city: 'Tokyo', price: 75,
      is_published: true, contract_agreement: true
    room.save!
    room.contract_agreement = false
    assert_not room.save, "Retracted contract agreement on published room"
  end
end
