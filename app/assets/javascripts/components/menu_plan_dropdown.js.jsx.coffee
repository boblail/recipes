class @MenuPlanDropdown extends React.Component
  @propTypes =
    recipes: React.PropTypes.object

  render: =>
    recipes = this.props.recipes
    if recipes.length > 0
      recipeList = recipes.map (recipe) ->
        `<NavRecipe key={recipe.get('id')}
                    recipe={recipe}/>`

      `<div>{recipeList}</div>`
    else
      `<h4 className="text-center"> No Recipes Added </h4>`
