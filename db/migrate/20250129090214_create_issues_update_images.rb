class CreateIssuesUpdateImages < ActiveRecord::Migration[8.0]
  def change
    create_table :issues_update_images do |t|
      t.string :path
      t.references :update, null: false, foreign_key: { to_table: :issues_updates }

      t.timestamps
    end
  end
end
