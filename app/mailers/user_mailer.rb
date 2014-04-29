class UserMailer < ActionMailer::Base

  default from: "do-not-reply@nebelscience.com"

  def forgot_password(user)
    @user = user

    mail to: @user.email, subject: "[Nebel Science] Forgot your password?"
  end

  def new_message_posted(message)
    @message = message

    authors = message.thread.map(&:author).map(&:email)
    recipients = admins + authors
    recipients.reject! { |email| email == message.author.email }.uniq!

    subject = "[Nebel Science] New #{message.reply? ? "reply" : "message"} posted."

    mail bcc: recipients, subject: subject
  end

  def charge_failed(user)
    @user = user

    mail to: @user.email, bcc: admins, subject: "[Nebel Science] Credit card charge failed."
  end

private

  def admins
    @admin_emails ||= User.admins.map(&:email)
  end

end
