class AddResponsibleSubjectToClient < ActiveRecord::Migration[8.0]
  def change
    add_reference :clients, :responsible_subject, foreign_key: true
  end
end
