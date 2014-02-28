class AddIndexToTopicsCode < ActiveRecord::Migration
  def change
    add_index :topics, :code, unique: true
  end
end
