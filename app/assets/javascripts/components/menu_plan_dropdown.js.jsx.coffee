class @MenuPlanDropdown extends React.Component
  @propTypes =
    recipes: React.PropTypes.object
    removeRecipe: React.PropTypes.func

  removeRecipe: (recipe) =>
    @props.removeRecipe(recipe)
    @setState(recipes: @props.recipes)

  render: =>
    recipes = @props.recipes
    removeRecipe = @removeRecipe
    doIt = @doIt
    if recipes.length > 0
      recipeList = recipes.map (recipe) ->
        `<NavRecipe key={recipe.get('id')}
                    recipe={recipe}
                    removeRecipe={removeRecipe}/>`

      `<div>{recipeList}</div>`
    else
      `<h4 className="text-center"> No Recipes Added </h4>`
