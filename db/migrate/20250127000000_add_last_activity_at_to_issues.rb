class AddLastActivityAtToIssues < ActiveRecord::Migration[7.1]
  def change
    add_column :issues, :last_activity_at, :datetime
    add_index :issues, :last_activity_at
  end
end
