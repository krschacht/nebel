class RequisitionsController < ApplicationController
  before_action :require_admin

  def destroy
    requisition = Requisition.where(material_id: params[:material_id], exercise_id: params[:exercise_id]).first
    requisition.destroy
    flash[:notice] = "That material is no longer associated with that exercise."
    redirect_to edit_material_path(params[:material_id])
  end
end
