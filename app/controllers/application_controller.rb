class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :current_user

  before_action :create_session_from_access_token_in_params

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

  def require_user
    if current_user.blank?
      session[:redirect_to] = request.env["PATH_INFO"]
      redirect_to root_path, alert: "You must be logged in to do that."
    end
  end

  def require_admin
    if current_user.blank? || !current_user.admin?
      session[:redirect_to] = request.env["PATH_INFO"]
      redirect_to root_path, alert: "You must be an admin to do that."
    end
  end

  def create_session_from_access_token_in_params
    return unless params[:access_token]

    if user = User.find_by(access_token: params[:access_token])
      session[:user_id] = user.id
    end
  end

end
