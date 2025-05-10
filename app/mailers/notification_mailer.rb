class NotificationMailer < ApplicationMailer
  layout "notification_mailer"

  def new_issue_user_comment(subscription, comment)
    @issue = comment.issue
    @comment = comment
    @user = subscription.subscriber

    mail to: @user.email, subject: "Odkaz pre starostu | Nový komentár", headers: list_unsubscribe_header
  end

  def new_issue_responsible_subject_comment(subscription, issue)
    @issue = issue
    @user = subscription.subscriber

    mail to: @user.email, subject: "Odkaz pre starostu | Nová odpoveď", headers: list_unsubscribe_header
  end

  def new_issue_agent_comment(subscription, comment)
    @issue = comment.issue
    @user = subscription.subscriber

    mail to: @user.email, subject: "Odkaz pre starostu | Nová odpoveď agent", headers: list_unsubscribe_header
  end

  def new_issue_update(subscription, issue)
    @issue = issue
    @user = subscription.subscriber

    mail to: @user.email, subject: "Odkaz pre starostu | Nová aktualizácia", headers: list_unsubscribe_header
  end

  def new_issue_verification(subscription, issue)
    @issue = issue
    @user = subscription.subscriber

    mail to: @user.email, subject: "Odkaz pre starostu | Overenie podnetu", headers: list_unsubscribe_header
  end

  def issue_accepted(subscription, issue)
    @issue = issue
    @user = subscription.subscriber

    mail to: @user.email, subject: "Odkaz pre starostu | Váš podnet bol zverejnený", headers: list_unsubscribe_header
  end

  def issue_unresolved(subscription, issue)
    @issue = issue
    @user = subscription.subscriber

    mail to: @user.email, subject: "Odkaz pre starostu | Podnet bol označený ako Neriešený", headers: list_unsubscribe_header
  end

  def issue_resolved(subscription, issue)
    @issue = issue
    @user = subscription.subscriber

    mail to: @user.email, subject: "Odkaz pre starostu | Podnet bol vyriešený", headers: list_unsubscribe_header
  end

  def issue_referred(subscription, issue)
    @issue = issue
    @user = subscription.subscriber

    mail to: @user.email, subject: "Odkaz pre starostu | Podnet bol odstúpený", headers: list_unsubscribe_header
  end

  def issue_closed(subscription, issue)
    @issue = issue
    @user = subscription.subscriber

    mail to: @user.email, subject: "Odkaz pre starostu | Podnet bol uzavretý", headers: list_unsubscribe_header
  end

  def issue_rejected(subscription, issue)
    @issue = issue
    @user = subscription.subscriber

    mail to: @user.email, subject: "Odkaz pre starostu | Podnet bol zamietnutý", headers: list_unsubscribe_header
  end

  private

  def list_unsubscribe_header
    {
      "List-Unsubscribe" => "<#{unsubscribe_global_url(token: @user.email_global_unsubscribe_token)}>",
      "List-Unsubscribe-Post" => "<List-Unsubscribe=One-Click>"
    }
  end
end
