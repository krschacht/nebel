class Requisition < ActiveRecord::Base
  validates_presence_of :exercise_id, :material_id
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  default_scope { order('id') } 

  belongs_to :exercise
  belongs_to :material
end
