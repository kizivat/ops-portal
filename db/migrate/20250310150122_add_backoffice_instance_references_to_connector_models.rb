class AddBackofficeInstanceReferencesToConnectorModels < ActiveRecord::Migration[8.0]
  def change
    add_reference :connector_tenants, :connector_backoffice_instance, foreign_key: true
    add_reference :connector_issues, :connector_backoffice_instance, foreign_key: true
    add_reference :connector_comments, :connector_backoffice_instance, foreign_key: true
    add_reference :connector_users, :connector_backoffice_instance, foreign_key: true
  end
end
