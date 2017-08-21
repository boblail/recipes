class @MenuPlan extends Backbone.Model
  urlRoot: '/menu-plans'

  addRecipe: (id) ->
    @recipes().add(id: id)
    @recipes().get(id).fetch()
    @save
      recipeIds: @recipes().pluck("id")

  removeRecipeId: (id) ->
    @recipes().remove(id: id)
    @save
      recipeIds: @recipes().pluck("id")

  recipes: ->
    @_recipes ||= new Recipes(@get('recipes'))
