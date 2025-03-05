class AddAuthorReferenceToIssuesDrafts < ActiveRecord::Migration[8.0]
  def change
    remove_column :issues_drafts, :author, :string
    add_reference :issues_drafts, :author, null: false, foreign_key: { to_table: :users }
  end
end
