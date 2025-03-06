class ChangeIssuesDraftsCategoriesAttributesToReferences < ActiveRecord::Migration[8.0]
  def change
    remove_column :issues_drafts, :category, :string
    remove_column :issues_drafts, :subcategory, :string
    remove_column :issues_drafts, :subtype, :string

    add_reference :issues_drafts, :category, null: true, foreign_key: { to_table: :issues_categories }
    add_reference :issues_drafts, :subcategory, null: true, foreign_key: { to_table: :issues_subcategories }
    add_reference :issues_drafts, :subtype, null: true, foreign_key: { to_table: :issues_subtypes }
  end
end
