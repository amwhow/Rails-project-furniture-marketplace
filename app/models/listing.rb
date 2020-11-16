class Listing < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  geocoded_by :location
  after_validation :geocode

  scope :search_by_title, -> (title) {where('title ILIKE ?', "%#{title}%") }
end
