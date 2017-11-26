class @RecipeDrawerHeader extends React.Component
  @propTypes =
    recipeCount: React.PropTypes.number
    open: React.PropTypes.bool
    toggleDrawer: React.PropTypes.func
  
  render: ->
    toggleDrawer = @props.toggleDrawer
    drawerIcon = if @props.open then "fa fa-chevron-down" else "fa fa-chevron-up"
    recipeCount = @props.recipeCount

    `<div className="card-header d-flex justify-content-between" onClick={toggleDrawer}>
      <span>
        Menu Plan <span className="badge badge-secondary">{recipeCount}</span>
      </span>
      
      <a><i className={drawerIcon} aria-hidden="true"></i></a>
    </div>`
