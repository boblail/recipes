class @RecipeDrawerList extends React.Component
  @propTypes =
    recipes: React.PropTypes.object

  render: ->
    `<ul className="list-group">{this.recipeList()}</ul>`

  recipeList: ->
    recipes = @props.recipes
    return @noRecipeElement() if recipes.isEmpty()

    recipes.map (recipe) -> `<DrawerRecipe key={recipe.get('id')} recipe={recipe}/>`

  noRecipeElement: ->
    `<p className='lead' style={{paddingLeft: '10px', paddingTop: '10px'}}> No Recipes</p>`

