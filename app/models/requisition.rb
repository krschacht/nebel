class Requisition < ActiveRecord::Base
  validates_presence_of :exercise_id, :material_id

  belongs_to :exercise
  belongs_to :material
end
