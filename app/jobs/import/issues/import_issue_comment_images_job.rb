module Import
  class Issues::ImportIssueCommentImagesJob < ApplicationJob
    def perform(comment:)
      Legacy::GenericModel.set_table_name("media_comments")
      Legacy::GenericModel.where(comment_id: comment.id).find_in_batches do |group|
        group.each do |legacy_record|
          comment.images.find_or_create_by!(
            id: legacy_record.id,
            path: legacy_record.href
          )
        end
      end
    end
  end
end
