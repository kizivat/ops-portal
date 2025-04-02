class DropTriageExternalAuthorIdentifierFromClients < ActiveRecord::Migration[8.0]
  def change
    remove_column :clients, :triage_external_author_identifier, :integer
  end
end
