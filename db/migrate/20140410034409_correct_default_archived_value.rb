class CorrectDefaultArchivedValue < ActiveRecord::Migration
  def up
    Material.where( :archived => nil ).update_all( archived: false )
    change_column :materials, :archived, :boolean, default: false, null: false
  end

  def down
    change_column :materials, :archived, :boolean, default: true, null: false
  end
end
