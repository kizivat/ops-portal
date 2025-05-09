module Notifications
  class PublishIssueStateChangedJob < ApplicationJob
    def perform(issue, state_id_change: [], notification_mailer: NotificationMailer)
      return unless state_id_change.present?

      issue.subscriptions.each do |subscription|
        user = subscription.subscriber
        next unless user.email_notifiable?

        case issue.state.key
        when "rejected"
          notification_mailer.issue_rejected(user, issue).deliver_later
        when "resolved"
          notification_mailer.issue_resolved(user, issue).deliver_later
        when "unresolved"
          notification_mailer.issue_unresolved(user, issue).deliver_later
        when "referred"
          notification_mailer.issue_referred(user, issue).deliver_later
        when "closed"
          notification_mailer.issue_closed(user, issue).deliver_later
        end
      end
    end
  end
end
