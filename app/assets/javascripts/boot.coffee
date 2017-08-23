drawRecipeMenuPlanControls = ($recipe) ->
  $recipe = $ $recipe
  id = $recipe.attr('data-id')
  $menuPlan = $recipe.find('.recipe-menu-plan')
  if window.currentMenuPlan.recipes().find(id: id)
    $menuPlan.html '<button class="menu-plan-remove-button" title="Remove from Menu Plan"></button>'
  else
    $menuPlan.html '<button class="menu-plan-add-button" title="Add to Menu Plan"></button>'

drawMenuPlanRecipeTotal = ->
  totalRecipes = window.currentMenuPlan.recipes().length
  $('.recipe-count').text(totalRecipes)

drawMenuPlanDropdown = ->
  navDropdown = document.getElementById("menu_plan_dropdown")
  ReactDOM.render React.createElement(MenuPlanDropdown, recipes: window.currentMenuPlan.recipes(), deleteRecipe: removeRecipe), navDropdown

removeRecipe = (recipe) ->
  id = recipe.get('id')
  window.currentMenuPlan.recipes().remove({id: id})
  $recipe = $("ul.recipes [data-id=#{id}]")

  drawRecipeMenuPlanControls($recipe)
  drawMenuPlanRecipeTotal()

$ ->
  $(document).on 'submit', 'form[method=get]', (e)->
    Turbolinks.visit "#{@action}#{if @action.indexOf('?') is -1 then '?' else '&'}#{$(@).serialize()}"
    false

document.addEventListener 'turbolinks:load', ->

  # only applies to recipes#show
  $('input.rating[type=number]')
    .rating()
    .change ->
      $input = $(@)
      $form = $input.closest('form')
      url = $form.attr('action') + '/ratings'

      $.put url,
        name: $input.attr('name')
        value: $input.val()

  $('.datepicker-container')
    .datepicker
      format: 'yyyy-mm-dd'
      endDate: moment().format('YYYY-MM-DD')
    .datepicker('update', moment().format('YYYY-MM-DD'))
    .on 'changeDate', (e) ->
      id = $(e.target).attr('for')
      $("##{id}").val moment(e.date).format('YYYY-MM-DD')

  $('input[name="s"]').click (e) ->
    $(e.target).closest('form').submit()

  if window.currentMenuPlan
    $(document.body).on 'click', '.menu-plan-remove-button', (e) ->
      $recipe = $(e.target).closest('.recipe')
      id = $recipe.attr('data-id')

      window.currentMenuPlan.recipes().remove({id: id})

      drawRecipeMenuPlanControls($recipe)
      drawMenuPlanRecipeTotal()
      drawMenuPlanDropdown()

    $(document.body).on 'click', '.menu-plan-add-button', (e) ->
      $recipe = $(e.target).closest('.recipe')
      id = $recipe.attr('data-id')

      window.currentMenuPlan.recipes().add({id: id})
      window.currentMenuPlan.recipes().get(id).fetch().then ->
        drawMenuPlanDropdown()

      drawRecipeMenuPlanControls($recipe)
      drawMenuPlanRecipeTotal()

    $('.recipe').each ->
      drawRecipeMenuPlanControls(@)

    drawMenuPlanRecipeTotal()

  if window.currentMenuPlan.recipes
    drawMenuPlanDropdown()
