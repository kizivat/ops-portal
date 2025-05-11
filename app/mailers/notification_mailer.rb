class NotificationMailer < ApplicationMailer
  layout "notification_mailer"

  before_action { @subscription = params[:subscription] }
  before_action { @user = @subscription.subscriber }
  before_action { @issue = @subscription.issue }
  default to: -> { @user.email }, headers: -> { list_unsubscribe_header }

  def new_issue_user_comment(comment)
    @comment = comment
    mail subject: "Odkaz pre starostu | Nový komentár"
  end

  def new_issue_responsible_subject_comment(comment)
    @comment = comment
    mail subject: "Odkaz pre starostu | Nová odpoveď"
  end

  def new_issue_update
    # TODO: remove this when issue update is implemented and view is ready
    raise NotImplementedError
    mail subject: "Odkaz pre starostu | Nová aktualizácia"
  end

  def new_issue_verification
    # TODO: remove this when issue verification is implemented and view is ready
    raise NotImplementedError

    mail subject: "Odkaz pre starostu | Overenie podnetu"
  end

  def issue_accepted
    mail subject: "Odkaz pre starostu | Váš podnet bol zverejnený"
  end

  def issue_unresolved
    mail subject: "Odkaz pre starostu | Podnet bol označený ako Neriešený"
  end

  def issue_resolved
    mail subject: "Odkaz pre starostu | Podnet bol vyriešený"
  end

  def issue_referred
    mail subject: "Odkaz pre starostu | Podnet bol odstúpený"
  end

  def issue_closed
    mail subject: "Odkaz pre starostu | Podnet bol uzavretý"
  end

  def issue_rejected
    mail subject: "Odkaz pre starostu | Podnet bol zamietnutý"
  end

  private

  def list_unsubscribe_header
    {
      "List-Unsubscribe" => "<#{unsubscribe_global_subscriptions_url(token: @user.email_global_unsubscribe_token)}>",
      "List-Unsubscribe-Post" => "<List-Unsubscribe=One-Click>"
    }
  end
end
