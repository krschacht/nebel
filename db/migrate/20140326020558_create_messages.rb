class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :author_id, null: false
      t.integer :object_id, null: false
      t.string :object_type, null: false
      t.string :subject, null: false
      t.text :body
      t.boolean :open, default: true, null: false
      t.integer :order, default: 0, null: false
      t.timestamps
    end

    add_index :messages, :author_id
    add_index :messages, [:object_id, :object_type]
    add_index :messages, :created_at
    add_index :messages, :updated_at
    add_index :messages, :open
    add_index :messages, :order
  end
end
