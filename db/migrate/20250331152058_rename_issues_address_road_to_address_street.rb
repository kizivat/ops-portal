class RenameIssuesAddressRoadToAddressStreet < ActiveRecord::Migration[8.0]
  def change
    rename_column :issues, :address_road, :address_street
  end
end
