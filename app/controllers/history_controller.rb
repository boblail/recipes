class HistoryController < ApplicationController
  before_action :authenticate_user!

  def index
    @preparations = current_user.cookbook.preparations.preload(:recipe, recipe: [:photo, :tags])
  end

end
