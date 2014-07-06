class Recipe < ActiveRecord::Base
  
  belongs_to :created_by, class_name: "User"
  
  validates :name, presence: true, length: {minimum: 5}
  validates :ingredients, presence: true
  validates :created_by, presence: true
  validates :effort, :cost, :healthiness, numericality: {range: 1..3, allow_nil: true}
  validates :rachel, :bob, numericality: {range: 1..5, allow_nil: true}
  
  def yumminess
    [bob, rachel].compact.avg
  end
  
  def tags=(value)
    super Array(value).reject(&:blank?).map(&:downcase).uniq
  end
  
end
