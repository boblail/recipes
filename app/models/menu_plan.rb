class MenuPlan < ApplicationRecord

  belongs_to :cookbook
  has_and_belongs_to_many :recipes

end
