drawRecipeMenuPlanControls = ($recipe) ->
  $recipe = $ $recipe
  id = $recipe.attr('data-id')
  $menuPlan = $recipe.find('.recipe-menu-plan')
  if window.currentMenuPlan.includesRecipeId(id)
    $menuPlan.html '<button class="menu-plan-remove-button">Remove from Menu Plan</button>'
  else
    $menuPlan.html '<button class="menu-plan-add-button">Add to Menu Plan</button>'

document.addEventListener 'turbolinks:load', ->
  $('input.rating[type=number]').each ->
    $(@).rating()

  $('.rating').change ->
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

    $(document.body).on 'click', '.menu-plan-add-button', (e) ->
      $recipe = $(e.target).closest('.recipe')
      id = $recipe.attr('data-id')
      window.currentMenuPlan.addRecipeId(id)
      drawRecipeMenuPlanControls($recipe)

    $('.recipe').each ->
      drawRecipeMenuPlanControls(@)
