class MessagesController < ApplicationController

  include MessagesHelper

  before_action :require_user, only: :create
  before_action :require_admin, only: [:show, :index, :toggle, :destroy]

  layout false, only: [:toggle, :destroy]

  def show
    @message = Message.find(params[:id])
  end

  def index
    params[:scope]  ||= "opened"
    @messages = Message.openers.unarchived.order(:created_at).paginate(:page => params[:page], :per_page => 50)
    @messages = params[:scope] == "opened" ? @messages.opened : @messages.closed
  end

  def create
    message_params = params.require(:message).permit(:messageable_id, :messageable_type, :subject, :body)

    if message_params[:messageable_type] == "Message"
      opener = Message.find message_params[:messageable_id]
      message = opener.new_reply(current_user, message_params[:body])
    else
      message = Message.new message_params
      message.author = current_user
    end

    if message.save
      UserMailer.new_message_posted(message).deliver
      redirect_to canonical_message_path(message), notice: "Your message has been posted."
    else
      redirect_to root_path, alert: "There was an error posting your message."
    end
  end

  def toggle
    @message = Message.find(params[:id])
    @message.update opened: !@message.opened
  end

  def destroy
    message = Message.find(params[:id])
    message.update archived: true
  end

end
