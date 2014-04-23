class RequisitionsController < ApplicationController
  before_action :require_admin
  before_action :set_requisition, only: [:edit, :update, :destroy]

  def destroy
    material_id = @requisition.material_id
    @requisition.destroy
    flash[:notice] = "That material is no longer associated with that exercise."
    redirect_to edit_material_path( material_id )
  end

  def create
    @requisition = Requisition.new( requisition_params )

    if @requisition.save
      flash[:notice] = "That material is now linked to exercise #{ params[:exercise_id] }."
      redirect_to edit_material_path( @requisition.material_id )
    else
      flash[:alert] = "There was an error linking this material."
      redirect_to edit_material_path( @requisition.material_id )
    end
  end

  def update
    if @requisition.update( requisition_params )
      exercise = @requisition.exercise
      redirect_to canonical_topic_path(exercise.topic.slug, anchor: "part-#{exercise.part}", material_id: @requisition.material.id), notice: 'Material was sucessfully updated.'
    else
      redirect_to canonical_topic_path(exercise.topic.slug, anchor: "part-#{exercise.part}", material_id: @requisition.material.id), alert: 'Error updating material.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_requisition
      @requisition = Requisition.find( params[:id] )
    end

    # Only allow a trusted parameter "white list" through.
    def requisition_params
      params.require(:requisition).permit(:material_id, :exercise_id, :quantity, :comment)
    end

end
