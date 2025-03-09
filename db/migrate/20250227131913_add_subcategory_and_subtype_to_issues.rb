class AddSubcategoryAndSubtypeToIssues < ActiveRecord::Migration[8.0]
  def change
    add_reference :issues, :subcategory, null: true, foreign_key: { to_table: :issues_subcategories }
    add_reference :issues, :subtype, null: true, foreign_key: { to_table: :issues_subtypes }
  end
end
