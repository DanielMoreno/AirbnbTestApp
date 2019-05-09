class BookingDateValidator < ActiveModel::Validator
  def validate(booking)
  	##check to see if valid data up to this point
  	return unless booking.errors.blank?

    if booking.start_date > booking.end_date
      booking.errors.add(:booking, "start date must be after the end date")
    elsif booking.start_date == booking.end_date
      booking.errors.add(:booking, "start date cannot be the same as the end date")
    end
  end
end