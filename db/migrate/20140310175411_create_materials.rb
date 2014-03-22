class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :name
      t.text :original_name
      t.text :description
      t.string :url
      t.timestamps
    end
  end
end
