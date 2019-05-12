##
# Value Object class for Booking's Confirmation Statuses
##
class ConfirmationStatus
  STATUSES = %w(pending, accepted, declined).freeze

  def initialize(confirmation_status)
    @confirmation_status = confirmation_status
  end
end