class @DrawerRecipe extends React.Component
  @propTypes =
    recipe: React.PropTypes.object

  render: ->
    id = this.props.recipe.get('id')
    removeRecipe = -> window.currentMenuPlan.removeRecipeId(id)

    `<li className="list-group-item">
      <a className="recipe-link" href={'/recipes/' +  id}>
        { this.props.recipe.get('name') }
      </a>
      <a className="remove-recipe" onClick={removeRecipe}>Remove</a>
    </li>`
