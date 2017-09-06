class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(user)
    request.env["omniauth.origin"] || stored_location_for(user) || my_recipes_path
  end

  def mobile_app?
    request.user_agent["RecipesApp"].present?
  end
  helper_method :mobile_app?

end
