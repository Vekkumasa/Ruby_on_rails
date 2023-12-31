class Beer < ApplicationRecord
  include RatingAverage
  belongs_to :brewery, touch: true
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :user

  validates :name, presence: true

  def to_s
    "#{name} (#{brewery.name})"
  end

  def average
    return 0 if ratings.empty?

    ratings.map{ :score }.sum / ratings.count.to_f
  end

  def self.top(amount)
    Beer.order(average_rating: :desc).limit(amount)
  end
end
