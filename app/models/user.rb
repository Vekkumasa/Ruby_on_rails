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
end
