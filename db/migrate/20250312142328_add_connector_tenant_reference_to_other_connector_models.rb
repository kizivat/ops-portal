class AddConnectorTenantReferenceToOtherConnectorModels < ActiveRecord::Migration[8.0]
  def change
    add_reference :connector_issues, :connector_tenant, null: false, foreign_key: true
    add_reference :connector_comments, :connector_tenant, null: false, foreign_key: true
    add_reference :connector_users, :connector_tenant, null: false, foreign_key: true
  end
end
