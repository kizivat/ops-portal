module Notifications
  class PublishIssueStateChangedJob < ApplicationJob
    def perform(issue, state_id_change: [], notification_mailer: NotificationMailer)
      return unless state_id_change.present?

      issue.subscriptions.each do |subscription|
        next unless subscription.subscriber.email_notifiable?

        case issue.state.key
        when "rejected"
          notification_mailer.issue_rejected(subscription, issue).deliver_later if issue.author == subscription.subscriber
        when "resolved"
          notification_mailer.issue_resolved(subscription, issue).deliver_later
        when "unresolved"
          notification_mailer.issue_unresolved(subscription, issue).deliver_later
        when "referred"
          notification_mailer.issue_referred(subscription, issue).deliver_later
        when "closed"
          notification_mailer.issue_closed(subscription, issue).deliver_later
        end
      end
    end
  end
end
