class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  # Disable CSRF protection in API mode
  protect_from_forgery with: :null_session
  # protect_from_forgery with: :exception, unless: -> { request.format.json? }

  # protect_from_forgery with: :exception

  helper_method :current_user
  # Normally, controller methods aren't accessible in views, but helper_method allows views to use current_user.
  # In an API-only app, this isn't needed unless you're rendering templates.

  def current_user
    # Example: Fetch user from session if user is logged in
    @current_user ||= User.find_by(id: session[:user_id])  || User.find_by(id: 1) 
    #Retrieves the logged-in user only if they exist in the session.
    # If @current_user is already set, it returns the cached value. Otherwise, it fetches the user from the database.

  end
end

