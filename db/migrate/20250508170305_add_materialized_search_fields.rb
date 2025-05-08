class AddMaterializedSearchFields < ActiveRecord::Migration[8.0]
  def up
    add_column :issues, :fulltext_extra, :string
    remove_index :issues, name: :issues_fulltext_idx

    expr = Issue.fulltext_index_expression(
      against: [ :title, :description, :legacy_id, :id, :fulltext_extra ],
      unaccent_f: :f_unaccent
    )

    add_index :issues, expr, using: :gin, name: :issues_fulltext_idx
  end

  def down
    remove_column :issues, :fulltext_extra
  end
end
