module Import
  class Issues::ImportIssueImagesJob < ApplicationJob
    def perform(issue:)
      Legacy::GenericModel.set_table_name("media_images")
      Legacy::GenericModel.where(alert_id: issue.id).find_in_batches do |group|
        group.each do |legacy_record|
          issue.images.find_or_create_by!(
            id: legacy_record.id,
            original: legacy_record.original,
            path: legacy_record.href,
            position: legacy_record.position,
            thumbnail: legacy_record.thumbnail
          )
        end
      end
    end
  end
end
