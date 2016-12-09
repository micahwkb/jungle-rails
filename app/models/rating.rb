class Rating < ActiveRecord::Base

  belongs_to :product
  validates :product_id, presence: true
  validates :rating, presence: true

end
