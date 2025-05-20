module Import
  class Blobs::PrefetchMunicipalityAlertsBlobsJob < ApplicationJob
    queue_with_priority 100

    def perform(
      municipality:,
      import_since: Date.parse("2020-01-01").beginning_of_day
    )
      Legacy::Alert.where(mesto: municipality.legacy_id)
                   .where(is_manual: 0)
                   .where("posted_time >= ?", import_since.to_i).find_in_batches do |group|
        group.each do |legacy_alert|
          Blobs::PrefetchAlertBlobsJob.perform_later(legacy_alert.id)
        end
      end
    end
  end
end
