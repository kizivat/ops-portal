module Import
  class Issues::ImportIssuePhotosJob < ApplicationJob
    include ImportHelper

    def perform(issue:)
      Legacy::GenericModel.set_table_name("media_images")
      Legacy::GenericModel.where(alert_id: issue.id).find_in_batches do |group|
        group.each do |legacy_record|
          issue.photos.attach(io: download_from_ops_portal(legacy_record.href), filename: File.basename(legacy_record.href))

          # issue.images.find_or_create_by!(
          #   id: legacy_record.id,
          #   original: legacy_record.original,
          #   path: legacy_record.href,
          #   position: legacy_record.position,
          #   thumbnail: legacy_record.thumbnail
          # )
        end
      end
    end
  end
end
