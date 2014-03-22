class AddArchivedToMaterials < ActiveRecord::Migration
  def change
    add_column :materials, :archived, :boolean
  end
end
