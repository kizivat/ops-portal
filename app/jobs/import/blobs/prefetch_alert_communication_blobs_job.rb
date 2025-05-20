module Import
  class Blobs::PrefetchAlertCommunicationBlobsJob < ApplicationJob
    queue_with_priority 100

    include ImportMethods

    def perform(communication_id)
      paths = Legacy::Alerts::CommunicationAttachment.where(communication_id: communication_id).pluck(:path)
      download_attachables_from_ops_portal(paths)
    end
  end
end
