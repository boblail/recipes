class MenuPlanPresenter
  attr_reader :menu_plan

  def initialize(menu_plan)
    @menu_plan = menu_plan
  end

  def to_json
    MultiJson.dump(as_json)
  end

  def as_json(*)
    { id: menu_plan.id,
      name: menu_plan.name,
      recipeIds: menu_plan.recipe_ids }
  end

end
