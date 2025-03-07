class CreateIssuesSubtypes < ActiveRecord::Migration[8.0]
  def change
    create_table :issues_subtypes do |t|
      t.string :name
      t.string :name_hu
      t.string :alias
      t.string :description
      t.string :description_hu
      t.boolean :catch_all, default: false
      t.integer :weight
      t.references :subcategory, null: false, foreign_key: { to_table: :issues_subcategories }
      t.integer :legacy_id

      t.timestamps

      t.index :legacy_id, unique: true
    end
  end
end
