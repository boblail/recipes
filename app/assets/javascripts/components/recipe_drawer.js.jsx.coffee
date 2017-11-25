class @RecipeDrawer extends React.Component
  @propTypes =
    recipes: React.PropTypes.object

  constructor: (props) ->
    super props
    @state =
      open: false

  toggleDrawer: =>
    drawerWrapper = document.getElementById 'recipe_drawer_wrapper'
    drawerBackground = document.getElementById 'drawer_background'

    if @state.open
      drawerWrapper.style.bottom = "0px"
      drawerWrapper.style.height = "48px"
    else
      offsetHeight = window.innerHeight
      drawerWrapper.style.height = "0px"
      drawerWrapper.style.bottom = "#{offsetHeight}px"
      drawerBackground.style.height = "#{offsetHeight}px"

    @setState
      open: !@state.open

  render: ->
    recipes = @props.recipes

    recipeList = unless recipes.isEmpty()
      recipes.map (recipe) -> `<DrawerRecipe key={recipe.get('id')} recipe={recipe}/>`
    else
      noRecipeStyles =
        paddingLeft: '10px'
        paddingTop: '10px'
      
      `<p className='lead' style={noRecipeStyles}> No Recipes</p>`

    drawerIcon = if @state.open then "fa fa-chevron-down" else "fa fa-chevron-up"

    `<div  id="recipe_drawer">
      <div id="drawer_background">
        <div className="card-header d-flex justify-content-between" onClick={this.toggleDrawer}>
          <span>
            My Recipes <span className="badge badge-secondary">{recipes.length}</span>
          </span>
          <a>
            <i className={drawerIcon} aria-hidden="true"></i>
          </a>
        </div>
        <ul className="list-group">
          {recipeList}
        </ul>
      </div>
    </div>`
