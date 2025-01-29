class CreateIssuesCommunicationAttachments < ActiveRecord::Migration[8.0]
  def change
    create_table :issues_communication_attachments do |t|
      t.references :communication, null: false, foreign_key: { to_table: :issues_communications }
      t.references :issue, null: false, foreign_key: true
      t.string :path
      t.string :name
      t.string :extension
      t.boolean :image

      t.timestamps
    end
  end
end
