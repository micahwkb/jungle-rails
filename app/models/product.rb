class Product < ActiveRecord::Base

  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  belongs_to :category
  has_many :ratings

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :category, presence: true

  def average_rating
    if self.ratings.count == 0
      return 0
    else
      self.ratings.average(:rating).round
    end
  end

  def url
    "https://s3-us-west-2.amazonaws.com/heroku-jungle/#{image.url.split('/').last}"
  end
end
