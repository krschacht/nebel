class TopicsController < ApplicationController
  before_action :require_user, only: [:index, :show]
  before_action :require_admin, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_topic, only: [:edit, :update, :destroy]

  layout "application"

  def index
    @subjects = Subject.all
    @topics_by_subject = @subjects.each_with_object({}) do |subject, object|
      object[subject] = subject.topics.order(:order)
    end
  end

  def show
    @topic = Topic.where(slug: params[:slug]).includes(:prerequisite_topics, :exercises).first

    render layout: "topics"
  end

  def new
    @topic = Topic.new
  end

  def edit
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      redirect_to @topic, notice: 'Topic was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @topic.update(topic_params)
      redirect_to @topic, notice: 'Topic was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @topic.destroy
    redirect_to topics_url, notice: 'Topic was successfully destroyed.'
  end

private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit([:subject_id, :name, :order, :overview,
      :progression, :objectives, :teachable_moments, :questions, :parents,
      :connections, :books, :code])
  end

end
