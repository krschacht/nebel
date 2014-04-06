class RequisitionsController < ApplicationController
  before_action :require_admin

  def destroy
    requisition = Requisition.find( params[:id] )
    material_id = requisition.material_id
    requisition.destroy
    flash[:notice] = "That material is no longer associated with that exercise."
    redirect_to edit_material_path( material_id )
  end

  def create
    @requisition = Requisition.new( params[:requisition].permit(:material_id, :exercise_id, :quantity) )

    if @requisition.save
      flash[:notice] = "That material is now linked to exercise #{ params[:exercise_id] }."
      redirect_to edit_material_path( @requisition.material_id )
    else
      flash[:alert] = "There was an error linking this material."
      redirect_to edit_material_path( @requisition.material_id )
    end
  end

  def update
    @requisition = Requisition.find( params[:id] )

    @requisition.quantity = params[:requisition][:quantity]

    if @requisition.save
      flash[:notice] = "The quantity was updated."
      redirect_to edit_material_path(params[:requisition][:material_id])
    else
      flash[:alert] = "There was an error updating the quantity."
      redirect_to edit_material_path(params[:requisition][:material_id])
    end
  end

end
