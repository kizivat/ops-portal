class AddAcceptedIssueState < ActiveRecord::Migration[8.0]
  def up
    Issues::State.find_or_initialize_by(key: "accepted").tap do |state|
      state.name = "Prijatý"
      state.color = "#FFFFFF"
    end.save!

    remove_index :issues, name: 'index_issues_municipality_search_hot_path' if index_name_exists?(:issues, name: 'index_issues_municipality_search_hot_path')
    remove_index :issues, name: 'index_issues_default_search_hot_path' if index_name_exists?(:issues, name: 'index_issues_default_search_hot_path')

    ids = Issues::State.not_visible.pluck(:id)
    add_index :issues, [ :municipality_id, :created_at ], where: "state_id NOT IN (#{ids.join(',')})", name: 'index_issues_municipality_search_hot_path'
    add_index :issues, [ :created_at ], where: "state_id NOT IN (#{ids.join(',')})", name: 'index_issues_default_search_hot_path'
  end

  def down
    Issues::State.find_by(key: "accepted")&.destroy

    remove_index :issues, name: 'index_issues_municipality_search_hot_path' if index_name_exists?(:issues, name: 'index_issues_municipality_search_hot_path')
    remove_index :issues, name: 'index_issues_default_search_hot_path' if index_name_exists?(:issues, name: 'index_issues_default_search_hot_path')

    ids = Issues::State.not_visible.pluck(:id)
    add_index :issues, [ :municipality_id, :created_at ], where: "state_id NOT IN (#{ids.join(',')})", name: 'index_issues_municipality_search_hot_path'
    add_index :issues, [ :created_at ], where: "state_id NOT IN (#{ids.join(',')})", name: 'index_issues_default_search_hot_path'
  end
end
