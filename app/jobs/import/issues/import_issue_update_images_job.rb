module Import
  class Issues::ImportIssueUpdateImagesJob < ApplicationJob
    def perform(update:)
      Legacy::GenericModel.set_table_name("media_updates")
      Legacy::GenericModel.where(update_id: update.id).find_in_batches do |group|
        group.each do |legacy_record|
          update.images.find_or_create_by!(
            id: legacy_record.id,
            path: legacy_record.href
          )
        end
      end
    end
  end
end
