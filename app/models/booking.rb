class Booking < ApplicationRecord
  after_initialize :init

  belongs_to :user
  belongs_to :room

  enum confirmation_status: { pending: 'pending', accepted: 'accepted', declined: 'declined' }

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :price, presence: true, numericality: true
  validates :total, presence: true, numericality: true

  validates_with BookingDateValidator, BookingPriceValidator, BookingTotalValidator, on: :create
  validates_with BookingAvailabilityValidator

  private
  	## After Initialize init function. Calculate total, set default values for statuses. 
    def init
      if(self.total.nil? && self.price && self.end_date && self.start_date )
        self.total = self.price * (self.end_date - self.start_date)
      end
      self.confirmation_status ||= 'pending'
      self.is_canceled = false if self.is_canceled.nil?
    end
end
