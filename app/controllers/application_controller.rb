class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

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

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
