class Listing < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  after_validation :geocode
  geocoded_by :location
end
