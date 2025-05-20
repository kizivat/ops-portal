module Import
  class Blobs::PrefetchAlertUpdateBlobsJob < ApplicationJob
    queue_with_priority 100

    include ImportMethods

    def perform(update_id)
      hrefs = Legacy::Alerts::UpdateImage.where(update_id: update_id).pluck(:href)
      download_attachables_from_ops_portal(hrefs)
    end
  end
end
