class UserMailer < ActionMailer::Base
  default from: "do-not-reply@nebelscience.com"

  def forgot_password(user)
    @user = user

    mail to: @user.email, subject: "[Nebel Science] Forgot your password?"
  end
end
