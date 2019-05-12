class Room < ApplicationRecord
  after_initialize :init

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

  validates_with RoomAgreementBeforePublished

  private
    ## After Initialize init function. Set default values for statuses. 
    def init
      self.is_active = true if self.is_active.nil?
      self.is_published = false if self.is_published.nil?
      self.contract_agreement = false if self.contract_agreement.nil?
    end
end
