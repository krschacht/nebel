class UserMailer < ActionMailer::Base

  default from: "do-not-reply@nebelscience.com"

  def forgot_password(user)
    @user = user

    mail to: @user.email, subject: "[Nebel Science] Forgot your password?"
  end

  def new_message_posted(message)
    @message = message

    admin_emails = User.admins.map(&:email)
    author_emails = message.thread.map(&:author).map(&:email)
    emails = admin_emails + author_emails
    emails.reject! { |email| email == message.author.email }.uniq!

    subject = "[Nebel Science] New #{message.reply? ? "reply" : "message"} posted."

    mail bcc: emails, subject: subject
  end

end
