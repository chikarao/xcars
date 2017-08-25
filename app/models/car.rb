class Car < ApplicationRecord
  belongs_to :user
  has_many :bookings
  #has_many :users, through: :bookings
  has_many :booked_users, through: :bookings, source: :user
  mount_uploader :photo, PhotoUploader
  geocoded_by :location
  after_validation :geocode, if: :location_changed?
end
