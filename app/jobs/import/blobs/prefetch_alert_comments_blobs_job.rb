module Import
  class Blobs::PrefetchAlertCommentsBlobsJob < ApplicationJob
    queue_with_priority 100

    def perform(alert_id)
      Legacy::Alerts::Comment.where(remoteid: alert_id).find_each do |alert_comment|
        Blobs::PrefetchAlertCommentBlobsJob.perform_later(alert_comment.id)
      end
    end
  end
end
