class Issues::SyncUserCommentToTriageJob < ApplicationJob
  queue_as :default

  def perform(user_comment, sync_job: ::SyncIssueActivitiesToTriageJob, notification_job: ::Notifications::PublishNewIssueCommentJob)
    # TODO make there are no other editable user_comments
    if user_comment.within_editing_window?
      self.class.set(wait_until: user_comment.editing_window_end).perform_later(user_comment)
      return
    end

    sync_job.perform_later(user_comment.issue)
    notification_job.perform_later(user_comment)
  end
end
