class Rating < ActiveRecord::Base
  
  belongs_to :recipe
  belongs_to :user
  
  validates :name, presence: true
  validates :value, numericality: {range: 1..5}
  
end
