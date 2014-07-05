class Recipe < ActiveRecord::Base
  
  validates :name, presence: true, length: {minimum: 5}
  validates :ingredients, presence: true
  validates :effort, :cost, :healthiness, numericality: {range: 1..3, allow_nil: true}
  validates :rachel, :bob, numericality: {range: 1..5, allow_nil: true}
  
  def yumminess
    [bob, rachel].compact.avg
  end
  
end
