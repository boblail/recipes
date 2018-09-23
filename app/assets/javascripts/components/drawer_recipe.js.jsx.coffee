class @DrawerRecipe extends React.Component
  @propTypes =
    recipe: React.PropTypes.object

  render: ->
    `<li className='list-group-item'>
      <a href={'/recipes/' +  this.props.recipe.get('id')}>
        { this.props.recipe.get('name') }
      </a>
    </li>`
