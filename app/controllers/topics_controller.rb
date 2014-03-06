class TopicsController < ApplicationController
  before_action :set_topic, only: [:edit, :update, :destroy]

  def index
    @topics = Topic.order(:code)
  end

  def show
    @topic = Topic.where(id: params[:id]).includes(:prerequisite_topics, :exercises).first
    @prerequisite_topics = @topic.prerequisite_topics
    @exercises = @topic.exercises.order(:name)
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
      :context, :objectives, :teachable_moments, :questions, :parents,
      :connections, :books, :code])
  end

end
