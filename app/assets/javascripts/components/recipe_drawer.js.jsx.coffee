class @RecipeDrawer extends React.Component
  @propTypes =
    recipes: React.PropTypes.object

  constructor: (props) ->
    super props
    @state =
      open: false

  handleClick: =>
    drawerWrapper = document.getElementById('recipe_drawer_wrapper')

    if @state.open
      drawerWrapper.style.bottom = "0px"
      drawerWrapper.style.height = "48px"
    else
      offsetHeight = document.getElementById('recipe_drawer').offsetHeight
      drawerWrapper.style.bottom = "#{offsetHeight}px"
      drawerWrapper.style.height = "0px"

    @setState
      open: !@state.open

  render: ->
    recipes = @props.recipes

    unless recipes.isEmpty()
      recipeList = recipes.map (recipe) ->
        `<DrawerRecipe key={recipe.get('id')}
                    recipe={recipe}/>`
    else
      recipeList = "No Recipes"

    `<div className="card" id="recipe_drawer" onClick={this.handleClick}>
      <div className="card-header">
        My Recipes <span className="badge badge-secondary">{recipes.length}</span>
      </div>
      <ul className="list-group">
        {recipeList}
      </ul>
    </div>`
