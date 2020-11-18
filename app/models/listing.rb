class Listing < ApplicationRecord
  validates :phone, length: { in: 8..12 }
  validates :title, presence: true

  has_many :listing_categories
  has_many :categories, through: :listing_categories
  belongs_to :user
  has_many_attached :images
  geocoded_by :location
  after_validation :geocode
  has_many :savelistings, dependent: :destroy

  scope :search_by_title, -> (title) {where('title ILIKE ?', "%#{title}%") }
  scope :search_by_category, -> (category) { joins(:categories).merge(Category.where('categories.name ILIKE ?', "%#{category}%")) }
  scope :search_by_condition, -> (condition) {where('condition ILIKE ?', "%#{condition}%") }
  scope :price_range, -> (min, max) { where('price > ? AND price < ?', min, max)}
  scope :search_by_delivery, -> (delivery) { where('delivery = ?', delivery) }
end
