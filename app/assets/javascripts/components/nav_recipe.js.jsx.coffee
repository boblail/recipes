class @NavRecipe extends React.Component
  @propTypes =
    recipe: React.PropTypes.object

  render: ->
    recipeUrl = "/recipes/#{@props.recipe.get('id')}"
    recipePhoto = this.props.recipe.get('photo')
    photoUrl = if recipePhoto then recipePhoto.filename.url else "http://via.placeholder.com/140x100"

    `<a className='dropdown-item' href={recipeUrl}>
      <img className='nav-photo' src={ photoUrl } />
      { this.props.recipe.get('name') }
    </a>`
