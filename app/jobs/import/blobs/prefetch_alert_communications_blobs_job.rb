module Import
  class Blobs::PrefetchAlertCommunicationsBlobsJob < ApplicationJob
    queue_with_priority 100

    def perform(alert_id)
      Legacy::Alerts::Communication.where(alert: alert_id).find_each do |alert_communication|
        Blobs::PrefetchAlertCommunicationBlobsJob.perform_later(alert_communication.id)
      end
    end
  end
end
