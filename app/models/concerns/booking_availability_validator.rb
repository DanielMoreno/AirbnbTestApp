##
# Validator to check there are no existing bookings at the time of the attempted booking.
# Optional Param: Acceptance - only fails if the booking's confirmation status is set to accepted.
##
class BookingAvailabilityValidator < ActiveModel::Validator
  def validate(booking)
  	##check to see if valid data up to this point
  	return unless booking.errors.blank?

    ## For existing bookings, do this validation only if they are being set to accepted.
    check_id = !booking.id.nil? && booking.confirmation_status == 'accepted'
    booking_id = booking.id.nil? ? 0 : booking.id

    if check_id || booking.id.nil?
      existing_bookings = booking.room.bookings.where(        
        "((bookings.start_date >= ? AND bookings.start_date <= ?)
          OR (bookings.end_date >= ? AND bookings.end_date <= ?)
          OR (bookings.start_date < ? AND bookings.end_date > ?))
          AND bookings.confirmation_status = 'accepted' AND NOT bookings.is_canceled
          AND (? OR bookings.id != ?)", 
          booking.start_date, booking.end_date,
          booking.start_date, booking.end_date,
          booking.start_date, booking.end_date,
          booking.id.nil?, booking_id)
      if existing_bookings.any?
      	booking.errors.add(:booking, "cannot be scheduled, existing bookings for this room exist at this time")
      end
    end
  end
end