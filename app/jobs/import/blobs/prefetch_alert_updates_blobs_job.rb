module Import
  class Blobs::PrefetchAlertUpdatesBlobsJob < ApplicationJob
    queue_with_priority 100

    def perform(alert_id)
      Legacy::Alerts::Update.where(alert: alert_id).find_each do |alert_update|
        Blobs::PrefetchAlertUpdateBlobsJob.perform_later(alert_update.id)
      end
    end
  end
end
