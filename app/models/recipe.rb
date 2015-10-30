class Recipe < ActiveRecord::Base

  belongs_to :created_by, class_name: "User"
  has_many :ratings

  validates :name, presence: true, length: {minimum: 5}
  validates :ingredients, presence: true
  validates :created_by, presence: true
  validates :effort, :cost, :healthiness, numericality: {range: 1..3, allow_nil: true}

  def yumminess(user)
    ratings.where(user_id: user.id).pluck(:value).avg
  end

  def tags=(value)
    super Array(value).reject(&:blank?).map(&:downcase).uniq
  end

  def rating_for(user, name=user.name)
    ratings.where(user_id: user.id, name: name.chomp).pluck(:value)[0]
  end

end
