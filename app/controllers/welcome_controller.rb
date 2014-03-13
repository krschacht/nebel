class WelcomeController < ApplicationController

  def index
  end

  def login
  end

  def check_login
    if params[:login] == 'demo@demo.com' && params[:password] == 'bfsu'
      redirect_to topics_path
    else
      redirect_to '/login'
    end
  end
end
