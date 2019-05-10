##
# Validator to check there are no existing bookings at the time of the attempted booking.
##
class BookingAvailabilityValidator < ActiveModel::Validator
  def validate(booking)
  	##check to see if valid data up to this point
  	return unless booking.errors.blank?

    existing_bookings = booking.room.bookings.where(        
    	"(bookings.start_date >= ? AND bookings.start_date <= ?)
        OR (bookings.end_date >= ? AND bookings.end_date <= ?)
        OR (bookings.start_date < ? AND bookings.end_date > ?)", 
        booking.start_date, booking.end_date,
        booking.start_date, booking.end_date,
        booking.start_date, booking.end_date)
    if existing_bookings.any?
    	booking.errors.add(:booking, "cannot be scheduled, existing bookings for this room exist at this time")
    end
  end
end