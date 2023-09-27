class Style < ApplicationRecord
  has_many :beers, dependent: :destroy

  def to_s
    name.to_s
  end

  def self.top(amount)
    Style.order(average_rating: :desc).limit(amount)
  end
end
