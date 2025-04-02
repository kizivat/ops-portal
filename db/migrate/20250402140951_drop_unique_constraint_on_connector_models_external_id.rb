class DropUniqueConstraintOnConnectorModelsExternalId < ActiveRecord::Migration[8.0]
  def up
    remove_index :connector_activities, :backoffice_external_id
    remove_index :connector_activities, :triage_external_id
    remove_index :connector_issues, :backoffice_external_id
    remove_index :connector_issues, :triage_external_id
    remove_index :connector_users, :external_id

    add_index :connector_activities, :backoffice_external_id
    add_index :connector_activities, :triage_external_id
    add_index :connector_issues, :backoffice_external_id
    add_index :connector_issues, :triage_external_id
    add_index :connector_users, :external_id
  end

  def down
    remove_index :connector_activities, :backoffice_external_id
    remove_index :connector_activities, :triage_external_id
    remove_index :connector_issues, :backoffice_external_id
    remove_index :connector_issues, :triage_external_id
    remove_index :connector_users, :external_id

    add_index :connector_activities, :backoffice_external_id, unique: true
    add_index :connector_activities, :triage_external_id, unique: true
    add_index :connector_issues, :backoffice_external_id, unique: true
    add_index :connector_issues, :triage_external_id, unique: true
    add_index :connector_users, :external_id, unique: true
  end
end
