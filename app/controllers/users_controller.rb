class UsersController < ApplicationController
  before_action :require_user, only: [:edit, :update]
  before_action :set_user, only: [:edit, :update]

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to topics_path, notice: 'User was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to edit_user_path(@user), notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def forgot_password
  end

  def send_access_email
    user = User.by_email(params[:email]).first

    if user.present?
      UserMailer.forgot_password(user).deliver
      redirect_to new_session_path, notice: "Your access link has been sent! Please check your email."
    else
      flash.now[:alert] = "There is no user with that email."
      render :forgot_password
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      if @user != current_user
        flash[:alert] = "You are not allowed to do that."
        redirect_to root_path
      end
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
