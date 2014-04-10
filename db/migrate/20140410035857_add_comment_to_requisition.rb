class AddCommentToRequisition < ActiveRecord::Migration
  def change
    add_column :requisitions, :comment, :string
  end
end
