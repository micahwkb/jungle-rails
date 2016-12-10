class Product < ActiveRecord::Base

  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  belongs_to :category
  # has_many :comments
  has_many :ratings

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :category, presence: true

  def average_rating
    if self.ratings.count == 0
      'unrated'
    else
      self.ratings.average(:rating).round
    end
  end
end
