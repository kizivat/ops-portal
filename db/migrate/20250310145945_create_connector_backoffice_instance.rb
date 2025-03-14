class CreateConnectorBackofficeInstance < ActiveRecord::Migration[8.0]
  def change
    create_table :connector_backoffice_instances do |t|
      t.string :url
      t.string :api_token
      t.string :webhook_secret
      t.timestamps
    end
  end
end
