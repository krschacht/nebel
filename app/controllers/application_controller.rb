class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

  def require_user
    if current_user.blank?
      redirect_to root_path, alert: "You must be logged in to do that."
    end
  end

  def require_admin
    if current_user.blank? || !current_user.admin?
      redirect_to root_path, alert: "You must be an admin to do that."
    end
  end

end
