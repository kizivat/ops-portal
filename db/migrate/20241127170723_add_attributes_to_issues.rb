class AddAttributesToIssues < ActiveRecord::Migration[8.0]
  def change
    add_column :issues, :history_data, :jsonb
  end
end
