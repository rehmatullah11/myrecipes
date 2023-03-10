class Recipe < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: {minimun:5 , maximum:500 }

  belongs_to :chef
end
