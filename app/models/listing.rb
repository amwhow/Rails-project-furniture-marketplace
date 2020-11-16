class Listing < ApplicationRecord
  has_many :listing_categories
  has_many :categories, through: :listing_categories
  belongs_to :user
  has_many_attached :images
  geocoded_by :location
  after_validation :geocode
  has_many :savelistings, dependent: :destroy

  scope :search_by_title, -> (title) {where('title ILIKE ?', "%#{title}%") }
end
