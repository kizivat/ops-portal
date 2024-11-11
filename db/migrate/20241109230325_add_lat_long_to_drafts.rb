class AddLatLongToDrafts < ActiveRecord::Migration[8.0]
  def change
    add_column :issues_drafts, :latitude, :float
    add_column :issues_drafts, :longitude, :float
  end
end
