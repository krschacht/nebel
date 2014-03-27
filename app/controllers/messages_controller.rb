class MessagesController < ApplicationController

  include MessagesHelper

  before_action :require_user, only: :create
  before_action :require_admin, only: :index

  def index
    @messages = Message.openers.order(:created_at)
  end

  def create
    message_params = params.require(:message).permit(:object_id, :object_type, :subject, :body)

    message = Message.new message_params
    message.author = current_user

    if message.save
      redirect_to message_path(message), notice: "Your message has been posted."
    else
      redirect_to root_path, alert: "There was an error posting your message."
    end
  end

end
