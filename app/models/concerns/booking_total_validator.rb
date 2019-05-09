class BookingTotalValidator < ActiveModel::Validator
  def validate(booking)
    ##check to see if valid data up to this point
    return unless booking.errors.blank?
    
    begin
      days = booking.end_date - booking.start_date
      calculatedTotal = days * booking.price
      if calculatedTotal != booking.total
        booking.errors.add(:booking, "total price of #{booking.price} does not match the calculated amount of #{calculatedTotal} for #{days} days")
      end
    end
  end
end