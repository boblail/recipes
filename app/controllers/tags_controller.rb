class TagsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tags = current_user.cookbook.tags
  end

end
