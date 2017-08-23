class @MenuPlan extends Backbone.Model
  urlRoot: '/menu-plans'

  recipes: ->
    @_recipes ||= new Recipes(@get('recipes'))
