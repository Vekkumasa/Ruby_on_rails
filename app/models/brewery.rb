class Brewery < ApplicationRecord
  include RatingAverage
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :year, numericality: {
    greater_than_or_equal_to: 1040,
    only_integer: true
  }

  validates :name, presence: true

  validate :year_cant_be_in_future,
           def year_cant_be_in_future
             return unless year.present? && year > Time.now.year

             errors.add(:year, "Year can't be in the future")
           end

  def ratings?
    !ratings.empty?
  end
end
