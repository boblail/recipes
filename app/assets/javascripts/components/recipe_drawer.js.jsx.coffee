class @RecipeDrawer extends React.Component
  @propTypes =
    recipes: React.PropTypes.object

  constructor: (props) ->
    super props
    @state = open: false

    @toggleDrawer = @toggleDrawer.bind @

  componentDidUpdate: ->
    @updateDrawerSize()

  toggleDrawer: =>
    @setState (prevState) ->
      open: !prevState.open

  render: ->
    recipes = @props.recipes

    `<div id="recipe_drawer_wrapper" className="col-lg-4 offset-lg-1 col-md-6 offset-md-2 col-sm-12">
      <div id="drawer_background" style={{height: window.offsetHeight}}>
        <RecipeDrawerHeader recipeCount={recipes.length}
                            open={this.state.open}
                            toggleDrawer={this.toggleDrawer} />
        <RecipeDrawerList recipes={recipes} />
      </div>
    </div>`

  updateDrawerSize: ->
    wrapper = document.getElementById("recipe_drawer_wrapper")
    values = if @state.open then { bottom: "#{@drawerHeight()}px", height: "0px" } else { bottom: "0px", height: "48px" }
    
    wrapper.style.bottom = values.bottom
    wrapper.style.height = values.height
  

  drawerHeight: ->
    Math.min.apply Math, [
      @drawerContentHeight()
      window.innerHeight
    ]

  drawerContentHeight: ->
    drawerWrapper = document.getElementById('recipe_drawer_wrapper')
    cardHeader = drawerWrapper.getElementsByClassName("card-header")[0]
    recipeList = drawerWrapper.getElementsByClassName("list-group")[0]
    cardHeader.offsetHeight + recipeList.offsetHeight

    