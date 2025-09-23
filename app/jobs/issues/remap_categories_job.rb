class Issues::RemapCategoriesJob < ApplicationJob
  queue_as :default

  def perform
    Issue.transaction do
      Issue.where.not(legacy_id: nil).find_each do |issue|
        next unless issue.category&.legacy_id.present?

        issue.legacy_data["legacy_category_id"] = issue.category&.legacy_id
        issue.legacy_data["legacy_subcategory_id"] = issue.subcategory&.legacy_id
        issue.legacy_data["legacy_subtype_id"] = issue.subtype&.legacy_id

        category, subcategory, subtype = CategoryMapper.map_legacy_categories_to_new(issue.category, issue.subcategory, issue.subtype)

        issue.category = category
        issue.subcategory = subcategory
        issue.subtype = subtype

        issue.save!
      end
    end
  end
end
