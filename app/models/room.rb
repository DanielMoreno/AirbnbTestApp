class Room < ApplicationRecord
  belongs_to :user
  has_many :bookings

  ## Intial information required to create a room
  validates :title, presence: true
  validates :home_type, presence: true
  validates :room_type, presence: true
  validates :accommodates, presence: true
  validates :city, presence: true
  validates :price, presence: true
  validates :summary, length: {maximum: 250}
end
