class ApplicationController < ActionController::Base
  def after_sign_in_path_for(user)
    request.env["omniauth.origin"] || stored_location_for(user) || my_recipes_path
  end

  def mobile_app?
    request.user_agent&.[]("RecipesApp").present?
  end
  helper_method :mobile_app?
end
