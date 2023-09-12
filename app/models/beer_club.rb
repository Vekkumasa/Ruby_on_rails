class BeerClub < ApplicationRecord
  has_many :membership
  has_many :users, dependent: :destroy, through: :membership
end
