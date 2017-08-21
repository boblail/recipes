class @DrawerRecipe extends React.Component
  @propTypes =
    recipe: React.PropTypes.object

  render: ->
    `<li className='list-group-item'>
      { this.props.recipe.get('name') }
    </li>`
