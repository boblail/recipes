drawRecipeMenuPlanControls = ($recipe) ->
  $recipe = $ $recipe
  id = $recipe.attr('data-id')
  $menuPlan = $recipe.find('.recipe-menu-plan')
  if window.currentMenuPlan.recipes().get(id)
    $menuPlan.html '<button class="menu-plan-remove-button" title="Remove from Menu Plan"></button>'
  else
    $menuPlan.html '<button class="menu-plan-add-button" title="Add to Menu Plan"></button>'

drawRecipeDrawer = ->
  recipeDrawer = document.getElementById("recipe_drawer_root")
  if recipeDrawer
    ReactDOM.render(React.createElement(RecipeDrawer, recipes: window.currentMenuPlan.recipes()), recipeDrawer)

$ ->
  $(document).on 'submit', 'form[method=get]', (e)->
    Turbolinks.visit "#{@action.replace(/\?.*/, "")}?#{$(@).serialize()}", action: "replace"
    false

  $(document).ajaxSend (e, jqxhr, settings)=>
    return if settings.type is 'GET'
    jqxhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')

document.addEventListener 'turbolinks:load', ->

  # only applies to recipes#show
  $('input.rating[type=number]')
    .rating()
    .change ->
      $input = $(@)
      $form = $input.closest('form')
      url = $form.attr('action') + '/ratings'

      $.put url,
        userId: $input.attr('data-id')
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
      window.currentMenuPlan.removeRecipeId(id)

    $(document.body).on 'click', '.menu-plan-add-button', (e) ->
      $recipe = $(e.target).closest('.recipe')
      id = $recipe.attr('data-id')
      window.currentMenuPlan.addRecipe(id)

    window.currentMenuPlan.on 'recipe:remove', (id) ->
      drawRecipeMenuPlanControls($ "[data-id=#{id}]")
      drawRecipeDrawer()

    window.currentMenuPlan.on 'recipe:add', (id) ->
      drawRecipeMenuPlanControls($ "[data-id=#{id}]")
      drawRecipeDrawer()

    $('.recipe').each ->
      drawRecipeMenuPlanControls(@)

    drawRecipeDrawer()
