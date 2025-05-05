class CreateLegacyIssueSubscription < ActiveRecord::Migration[8.0]
  def change
    create_table :legacy_issue_subscriptions do |t|
      t.belongs_to :issue, null: false
      t.belongs_to :subscriber, null: false

      t.timestamps
    end

    add_foreign_key :legacy_issue_subscriptions, :issues, on_delete: :cascade
    add_foreign_key :legacy_issue_subscriptions, :legacy_agents, column: :subscriber_id, on_delete: :cascade
    add_index :legacy_issue_subscriptions, [ :issue_id, :subscriber_id ], unique: true
  end
end
