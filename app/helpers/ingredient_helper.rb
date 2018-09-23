module IngredientHelper

  def formatted_amount(ingredient)
    amount = ingredient.amount
    amount = amount.join("-") if amount.respond_to? :join

    "#{amount} #{ingredient.unit.to_s.pluralize}"
  end

end
