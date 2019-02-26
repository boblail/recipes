class @RecipeDrawerHeader extends React.Component
  @propTypes =
    recipeCount: React.PropTypes.number

  render: ->
    recipeCount = @props.recipeCount

    `<div className="card-header">
      <span>
        Menu Plan <span className="badge badge-secondary">{recipeCount}</span>
      </span>
    </div>`
