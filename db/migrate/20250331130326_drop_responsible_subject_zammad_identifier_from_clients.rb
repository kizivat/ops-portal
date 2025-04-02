class DropResponsibleSubjectZammadIdentifierFromClients < ActiveRecord::Migration[8.0]
  def change
    remove_column :clients, :responsible_subject_zammad_identifier, :string
  end
end
