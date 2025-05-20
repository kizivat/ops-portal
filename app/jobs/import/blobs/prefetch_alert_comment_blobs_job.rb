module Import
  class Blobs::PrefetchAlertCommentBlobsJob < ApplicationJob
    queue_with_priority 100

    include ImportMethods

    def perform(comment_id)
      hrefs = Legacy::Alerts::CommentAttachment.where(comment_id: comment_id).pluck(:href)
      download_attachables_from_ops_portal(hrefs)
    end
  end
end
