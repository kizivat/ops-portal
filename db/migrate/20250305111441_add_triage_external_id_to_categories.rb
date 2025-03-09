class AddTriageExternalIdToCategories < ActiveRecord::Migration[8.0]
  def change
    add_column :issues_categories, :triage_external_id, :integer
  end
end
