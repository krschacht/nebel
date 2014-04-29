class AddTrialEndsAtToUsers < ActiveRecord::Migration
  def up
    add_column :users, :trial_ends_at, :datetime

    User.find_each do |user|
      user.update_attribute :trial_ends_at, 30.days.from_now
    end

    change_column :users, :trial_ends_at, :datetime, null: false

    add_index :users, :trial_ends_at
  end

  def down
    remove_column :users, :trial_ends_at
  end
end
