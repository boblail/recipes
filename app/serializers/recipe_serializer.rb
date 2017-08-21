class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name

  belongs_to :photo, optional: true
end
