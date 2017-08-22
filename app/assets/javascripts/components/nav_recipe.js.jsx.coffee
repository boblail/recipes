class @NavRecipe extends React.Component
  @propTypes =
    recipe: React.PropTypes.object
    removeRecipe: React.PropTypes.func

  handleClick: =>
    @props.removeRecipe(@props.recipe)

  render: =>
    recipe = @props.recipe
    recipeUrl = "/recipes/#{recipe.get('id')}"
    recipePhoto = @props.recipe.get('photo')
    photoUrl = if recipePhoto then recipePhoto.filename.url else "http://via.placeholder.com/140x100"

    `<div className='dropdown-item'>
      <a href={recipeUrl}>
        <img className='nav-photo' src={ photoUrl } />
        { recipe.get('name') }
      </a>
      <i className="fa fa-minus-circle" aria-hidden="true" onClick={this.handleClick}></i>
    </div>`
