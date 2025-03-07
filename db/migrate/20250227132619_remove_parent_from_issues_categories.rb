class RemoveParentFromIssuesCategories < ActiveRecord::Migration[8.0]
  def change
    remove_reference :issues_categories, :parent, null: true, foreign_key: { to_table: :issues_categories }
  end
end
