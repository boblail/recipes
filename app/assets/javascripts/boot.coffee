drawRecipeMenuPlanControls = ($recipe) ->
  $recipe = $ $recipe
  id = $recipe.attr('data-id')
  $menuPlan = $recipe.find('.recipe-menu-plan')
  if window.currentMenuPlan.includesRecipeId(id)
    $menuPlan.html '<button class="menu-plan-remove-button" title="Remove from Menu Plan"></button>'
  else
    $menuPlan.html '<button class="menu-plan-add-button" title="Add to Menu Plan"></button>'

drawMenuPlanRecipeTotal = ->
  totalRecipes = window.currentMenuPlan.get('recipeIds').length
  $('.recipe-count').text(totalRecipes)

$ ->
  $(document).on 'submit', 'form[method=get]', (e)->
    Turbolinks.visit "#{@action}#{if @action.indexOf('?') is -1 then '?' else '&'}#{$(@).serialize()}"
    false

document.addEventListener 'turbolinks:load', ->
  $('input.rating[type=number]')
    .rating()
    .change ->
      $input = $(@)
      $form = $input.closest('form')
      url = $form.attr('action') + '/ratings'

      $.put url,
        name: $input.attr('name')
        value: $input.val()

  if window.currentMenuPlan
    $(document.body).on 'click', '.menu-plan-remove-button', (e) ->
      $recipe = $(e.target).closest('.recipe')
      id = $recipe.attr('data-id')
      window.currentMenuPlan.removeRecipeId(id)
      drawRecipeMenuPlanControls($recipe)
      drawMenuPlanRecipeTotal()

    $(document.body).on 'click', '.menu-plan-add-button', (e) ->
      $recipe = $(e.target).closest('.recipe')
      id = $recipe.attr('data-id')
      window.currentMenuPlan.addRecipeId(id)
      drawRecipeMenuPlanControls($recipe)
      drawMenuPlanRecipeTotal()

    $('.recipe').each ->
      drawRecipeMenuPlanControls(@)

    drawMenuPlanRecipeTotal()
