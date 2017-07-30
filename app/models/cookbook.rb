class Cookbook < ActiveRecord::Base

  has_many :users
  has_many :recipes

end
