class TopicsController < ApplicationController
  before_action :require_user, only: [:index, :show, :complete]
  before_action :require_admin, only: [:new, :edit, :create, :update]
  before_action :set_topic, only: [:edit, :update]

  def index
    @subjects = Subject.all
    @completions = current_user.completions
    @topics_by_subject = @subjects.each_with_object({}) do |subject, object|
      object[subject] = subject.topics.order(:order)
    end
  end

  def show
    @topic = Topic.where(slug: params[:slug]).includes(:prerequisite_topics, :exercises).first
    @exercises = @topic.exercises.order(:part)
    @previous_topics = @topic.previous(2)
    @next_topics = @topic.next(2)
    @completed = current_user.completions.where(topic_id: @topic.id).present?
  end

  def new
    @topic = Topic.new
  end

  def edit
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      redirect_to edit_topic_path(@topic), notice: 'Topic was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @topic.update(topic_params)
      redirect_to edit_topic_path(@topic), notice: 'Topic was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def complete
    completion = Completion.find_or_initialize_by user_id: current_user.id, topic_id: params[:id]

    completion.new_record? ? completion.save! : completion.delete

    render nothing: true
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
