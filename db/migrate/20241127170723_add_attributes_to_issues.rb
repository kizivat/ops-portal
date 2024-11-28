class AddAttributesToIssues < ActiveRecord::Migration[8.0]
  def change
    add_column :issues, :municipality_id, :integer
    add_column :issues, :category_id, :integer
    add_column :issues, :embed, :string
    add_column :issues, :latitude, :float
    add_column :issues, :longitude, :float
    add_column :issues, :map_zoom, :integer
    add_column :issues, :accuracy, :integer
    add_column :issues, :published_at, :datetime
    add_column :issues, :front_page, :boolean
    add_column :issues, :mms, :boolean
    add_column :issues, :soft_reject, :boolean
    add_column :issues, :anonymous, :boolean
    add_column :issues, :owner_id, :integer
    add_column :issues, :new_owner_id, :integer
    add_column :issues, :modified_at, :datetime # mozno staci iba updated_at
    add_column :issues, :updated_by_id, :integer
    add_column :issues, :last_status_changed_at, :datetime
    add_column :issues, :municipal_district_id, :integer
    add_column :issues, :road_id, :integer
    add_column :issues, :responsibility_type_id, :integer
    add_column :issues, :responsibility_id, :integer
    add_column :issues, :mobile, :boolean
    add_column :issues, :ip, :inet
    add_column :issues, :secure, :string
    add_column :issues, :discussion_allowed, :boolean
    add_column :issues, :like_count, :integer
    add_column :issues, :comment_count_7d, :integer
    add_column :issues, :like_count_7d, :integer
    add_column :issues, :question, :boolean
    add_column :issues, :responsibility_set, :boolean
    add_column :issues, :responsibility_set_at, :datetime
    add_column :issues, :platform, :string
    add_column :issues, :reg_symbol, :string
    add_column :issues, :internal_state_id, :integer
    add_column :issues, :label_id, :integer
    add_column :issues, :note, :string
    add_column :issues, :posted_by_municipality_user_id, :integer
    add_column :issues, :manual, :boolean
    add_column :issues, :source_id, :integer
    add_column :issues, :organizational_unit_id, :integer
    add_column :issues, :ended_at, :datetime
    add_column :issues, :parent_id, :integer
    add_column :issues, :organizational_unit2_id, :integer
  end
end
