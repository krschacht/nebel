class MessagesController < ApplicationController

  include MessagesHelper

  before_action :require_user, only: :create
  before_action :require_admin, only: [:show, :index, :toggle]

  layout false, only: :toggle

  def show
    @message = Message.find(params[:id])
  end

  def index
    params[:scope] ||= "opened"
    @messages = Message.openers.order(:created_at)
    @messages = params[:scope] == "opened" ? @messages.opened : @messages.closed
  end

  def create
    message_params = params.require(:message).permit(:object_id, :object_type, :subject, :body)

    if message_params[:object_type] == "Message"
      opener = Message.find message_params[:object_id]
      message = opener.new_reply(current_user, message_params[:body])
    else
      message = Message.new message_params
      message.author = current_user
    end

    if message.save
      redirect_to canonical_message_path(message), notice: "Your message has been posted."
    else
      redirect_to root_path, alert: "There was an error posting your message."
    end
  end

  def toggle
    @message = Message.find(params[:id])
    @message.update_attribute(:open, !@message.open)
  end

end
