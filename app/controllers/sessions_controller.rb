class SessionsController < ApplicationController

  before_action :require_user, only: :destroy

  def new
  end

  def create
    user = User.by_email(params[:email]).first

    if user && user.password == params[:password]
      session[:user_id] = user.id
      flash[:notice] = "Welcome back, #{user.name}."
      redirect_to topics_url
    else
      flash[:alert] = "Your email or password is incorrect."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

end
