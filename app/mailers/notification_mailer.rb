class NotificationMailer < ApplicationMailer
  layout "notification_mailer"

  def new_issue_user_comment(subscriber, comment)
    @issue = comment.issue
    @comment = comment
    @subscriber = subscriber

    mail to: @subscriber.email, subject: "Odkaz pre starostu | Nový komentár"
  end

  def new_issue_responsible_subject_comment(subscriber, issue)
    @issue = issue
    @subscriber = subscriber

    mail to: @subscriber.email, subject: "Odkaz pre starostu | Nová odpoveď"
  end

  def new_issue_agent_comment(subscriber, comment)
    @issue = comment.issue
    @subscriber = subscriber

    mail to: @subscriber.email, subject: "Odkaz pre starostu | Nová odpoveď agent" # TODO: check if this should exist
  end

  def new_issue_update(subscriber, issue)
    @issue = issue
    @subscriber = subscriber

    mail to: @subscriber.email, subject: "Odkaz pre starostu | Nová aktualizácia"
  end

  def new_issue_verification(subscriber, issue)
    @issue = issue
    @subscriber = subscriber

    mail to: @subscriber.email, subject: "Odkaz pre starostu | Overenie podnetu"
  end

  def issue_accepted(subscriber, issue)
    @issue = issue
    @subscriber = subscriber

    mail to: @subscriber.email, subject: "Odkaz pre starostu | Váš podnet bol zverejnený"
  end

  def issue_unresolved(subscriber, issue)
    @issue = issue
    @subscriber = subscriber

    mail to: @subscriber.email, subject: "Odkaz pre starostu | Podnet bol označený ako Neriešený"
  end

  def issue_resolved(subscriber, issue)
    @issue = issue
    @subscriber = subscriber

    mail to: @subscriber.email, subject: "Odkaz pre starostu | Podnet bol vyriešený"
  end

  def issue_referred(subscriber, issue)
    @issue = issue
    @subscriber = subscriber

    mail to: @subscriber.email, subject: "Odkaz pre starostu | Podnet bol odstúpený"
  end

  def issue_closed(subscriber, issue)
    @issue = issue
    @subscriber = subscriber

    mail to: @subscriber.email, subject: "Odkaz pre starostu | Podnet bol uzavretý"
  end

  def issue_rejected(subscriber, issue)
    @issue = issue
    @subscriber = subscriber

    mail to: @subscriber.email, subject: "Odkaz pre starostu | Podnet bol zamietnutý" # TODO: check if this should exist
  end
end
