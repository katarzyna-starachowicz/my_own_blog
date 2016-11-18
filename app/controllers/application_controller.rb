class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :admin_signed_in?

  def store_location
    session[:return_to] = request.env['PATH_INFO']
  end

  def access_denied
    store_location
    redirect_to new_user_session_path,
                notice: 'To access this page you must be logged as an admin.'
  end

  def authenticate_admin!
    access_denied unless current_user.try(:admin?)
  end

  def admin_signed_in?
    current_user.try(:admin?)
  end
end
