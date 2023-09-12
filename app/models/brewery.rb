class Brewery < ApplicationRecord
  include RatingAverage
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def has_ratings
    return ratings.length() > 0
  end

end
