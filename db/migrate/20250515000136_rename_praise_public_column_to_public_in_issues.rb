class RenamePraisePublicColumnToPublicInIssues < ActiveRecord::Migration[8.0]
  def change
    rename_column :issues, :praise_public, :public
  end
end
