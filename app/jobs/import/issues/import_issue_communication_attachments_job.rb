module Import
  class Issues::ImportIssueCommunicationAttachmentsJob < ApplicationJob
    def perform(communication:)
      Legacy::GenericModel.set_table_name("communication_attachments")
      Legacy::GenericModel.where(communication_id: communication.id).find_in_batches do |group|
        group.each do |legacy_record|
          communication.attachments.find_or_create_by!(
            id: legacy_record.id,
            extension: legacy_record.extension,
            image: legacy_record.is_image,
            name: legacy_record.name,
            path: legacy_record.path,
            issue: ::Issue.find_by_id(legacy_record.alert_id)
          )
        end
      end
    end
  end
end
