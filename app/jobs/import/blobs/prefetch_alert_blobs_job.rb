module Import
  class Blobs::PrefetchAlertBlobsJob < ApplicationJob
    queue_with_priority 100

    include ImportMethods

    def perform(alert_id)
      Blobs::PrefetchAlertUpdatesBlobsJob.perform_later(alert_id)
      Blobs::PrefetchAlertCommentsBlobsJob.perform_later(alert_id)
      Blobs::PrefetchAlertCommunicationsBlobsJob.perform_later(alert_id)

      paths = Legacy::Alerts::Image.where(alert_id: alert_id).pluck(:original)
      download_attachables_from_ops_portal(paths)
    end
  end
end
