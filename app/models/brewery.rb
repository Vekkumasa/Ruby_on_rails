class Brewery < ApplicationRecord
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def has_ratings
    return ratings.length() > 0
  end
  def average_rating
    sum = ratings.reduce(0) { |sum, rating| sum + rating.score }
    pluralized_rating = "rating".pluralize(ratings.length())
    return "Brewery has #{ratings.length()} #{pluralized_rating} with an average of #{sum / ratings.length()}"
  end
end
