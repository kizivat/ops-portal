module Notifications
  class PublishNewIssueCommentJob < ApplicationJob
    def perform(comment, notification_mailer: NotificationMailer)
      issue = comment.issue

      issue.subscriptions.each do |subscription|
        user = subscription.subscriber
        next unless user.email_notifiable?
        next if comment.author?(user)

        case comment
        when Issues::UserComment
          notification_mailer.new_issue_user_comment(user, comment).deliver_later
        when Issues::ResponsibleSubjectComment
          notification_mailer.new_issue_responsible_subject_comment(user, comment).deliver_later
        when Issues::AgentComment, Issues::AgentPrivateComment
          notification_mailer.new_issue_agent_comment(user, comment).deliver_later
        end
      end
    end
  end
end
