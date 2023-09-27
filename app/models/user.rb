class User < ApplicationRecord
  include RatingAverage
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :membership, dependent: :destroy
  has_many :beer_clubs, through: :membership
  has_secure_password

  validates :username, uniqueness: true,
                       length: {
                         minimum: 3,
                         maximum: 30
                       }

  validates :password, length: { minimum: 4 }

  validate :password_contains_stuff

  def password_contains_stuff
    pattern = /[A-Z]/ =~ password && /\d/ =~ password
    return if pattern

    errors.add(:password, "must contain at least one capitalized letter and at least one number")
  end

  def self.most_ratings
    User.joins(:ratings).group('users.id').order('COUNT(ratings.id) DESC').limit(3)
  end

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def ratings_by_style_hash
    ratings_by_style = Hash.new(0)
    ratings.each do |rating|
      beer_style = rating.beer.style
      ratings_by_style[beer_style] += 1
    end

    ratings_by_style
  end

  def favorite_style
    return nil if ratings.empty?

    ratings_by_style = ratings_by_style_hash

    max_count = 0
    most_rated_style = nil

    ratings_by_style.each do |style, count|
      if count > max_count
        max_count = count
        most_rated_style = style
      end
    end

    most_rated_style.name
  end

  def favorite_brewery
    return nil if ratings.empty?

    max_count = 0
    best_brewery = nil

    ratings_by_style = Hash.new(0)
    ratings.each do |rating|
      beer_style = rating.beer.style
      brewery_name = rating.beer.brewery.name
      ratings_by_style[beer_style] += 1
      if ratings_by_style[beer_style] > max_count
        max_count = ratings_by_style[beer_style]
        best_brewery = brewery_name
      end
    end

    best_brewery
  end
end
