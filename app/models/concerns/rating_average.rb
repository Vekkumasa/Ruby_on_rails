module RatingAverage
  extend ActiveSupport::Concern

  def average_rating(beer_or_brewery)
    sum = ratings.reduce(0) { |res, rating| res + rating.score }
    pluralized_rating = "rating".pluralize(ratings.length)
    "#{beer_or_brewery} has #{ratings.length} #{pluralized_rating} with an average of #{sum / ratings.length}"
  end
end
