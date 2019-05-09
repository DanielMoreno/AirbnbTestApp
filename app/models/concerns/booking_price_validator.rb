class BookingPriceValidator < ActiveModel::Validator
  def validate(booking)
  	##check to see if valid data up to this point
  	return unless booking.errors.blank?
  	
    if booking.price != booking.room.price
      booking.errors.add(:booking, "price of the booking, #{booking.price} does not match the price of the room, #{booking.room.price}")
    end
  end
end