class Beer < ApplicationRecord
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  def average_rating
    sum = ratings.reduce(0) { |sum, rating| sum + rating.score }
    pluralized_rating = "rating".pluralize(ratings.length())
    return "Beer has #{ratings.length()} #{pluralized_rating} with an average of #{sum / ratings.length()}"
  end

  def to_s
    "#{name} (#{brewery.name})"
  end
end
