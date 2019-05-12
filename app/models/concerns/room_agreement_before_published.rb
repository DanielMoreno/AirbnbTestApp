##
# Validator to that a room has accepted the Contract Agreement before the room can be published.
##
class RoomAgreementBeforePublished < ActiveModel::Validator
  def validate(room)
  	##check to see if valid data up to this point
  	return unless room.errors.blank?

    if !room.is_published.nil? && room.is_published && (room.contract_agreement.nil? || !room.contract_agreement)
      room.errors.add(:room, "cannot be published until the Contract Agreement has been accepted. Contract Agreement cannot be denied while published.")
    end
  end
end