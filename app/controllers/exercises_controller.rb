class ExercisesController < ApplicationController
  before_action :require_user, only: :show
  before_action :require_admin, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_exercise, only: [:edit, :update, :destroy]

  # GET /exercises/new
  def new
    @exercise = Exercise.new
  end

  # GET /exercises/1/edit
  def edit
  end

  # POST /exercises
  def create
    @exercise = Exercise.new(exercise_params)

    if @exercise.save
      redirect_to edit_exercise_path(@exercise), notice: 'Exercise was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /exercises/1
  def update
    if @exercise.update(exercise_params)
      redirect_to edit_exercise_path(@exercise), notice: 'Exercise was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /exercises/1
  def destroy
    @exercise.destroy
    redirect_to root_path, notice: 'Exercise was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise
      @exercise = Exercise.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def exercise_params
      params.require(:exercise).permit(:topic_id, :name, :duration, :body)
    end
end
