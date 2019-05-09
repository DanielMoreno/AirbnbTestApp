class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :price, presence: true, numericality: true
  validates :total, presence: true, numericality: true

  validates_with BookingDateValidator, BookingPriceValidator, BookingTotalValidator, BookingAvailabilityValidator, on: :create
end
