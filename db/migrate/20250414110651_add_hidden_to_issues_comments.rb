class AddHiddenToIssuesComments < ActiveRecord::Migration[8.0]
  def change
    add_column :issues_comments, :hidden, :boolean, default: false
  end
end
