class @RecipeDrawer extends React.Component
  @propTypes =
    recipes: React.PropTypes.object

  constructor: (props) ->
    super props
    @state = open: false

    @toggleDrawer = @toggleDrawer.bind @

  toggleDrawer: =>
    @setState (prevState) ->
      open: !prevState.open

  render: ->
    recipes = @props.recipes

    `<div className="recipe-drawer-wrapper">
      <RecipeDrawerHeader recipeCount={recipes.length}
                          open={this.state.open}
                          toggleDrawer={this.toggleDrawer} />
      <RecipeDrawerList recipes={recipes} />
    </div>`
