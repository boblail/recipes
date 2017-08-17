class @MenuPlan extends Backbone.Model
  urlRoot: '/menu-plans'

  includesRecipeId: (id) ->
    +id in @get('recipeIds')

  addRecipeId: (id) ->
    @save
      recipeIds: @get('recipeIds').concat([+id])

  removeRecipeId: (id) ->
    @save
      recipeIds: _.without(@get('recipeIds'), +id)
