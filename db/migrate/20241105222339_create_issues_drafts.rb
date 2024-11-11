class CreateIssuesDrafts < ActiveRecord::Migration[8.0]
  def change
    create_table :issues_drafts do |t|
      t.string :title
      t.string :description
      t.string :author
      t.boolean :anonymous

      t.timestamps
    end
  end
end
