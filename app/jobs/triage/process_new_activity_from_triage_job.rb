class Triage::ProcessNewActivityFromTriageJob < ApplicationJob
  FRONTEND_MESSAGE_TAG = ENV.fetch("OPS_PORTAL_ARTICLE_FROM_BACKOFFICE_TAG", "[[ops portal]]")
  BACKOFFICE_MESSAGE_TAG = ENV.fetch("RESPONSIBLE_SUBJECT_ARTICLE_TAG", "[[pre zodpovedny subjekt]]")

  def perform(ticket_id, article_id, triage_zammad_client: TriageZammadEnvironment.client, webhook_client: WebhookClient)
    article = triage_zammad_client.get_article(ticket_id, article_id)

    if article[:body].include? BACKOFFICE_MESSAGE_TAG
      responsible_subject_hash = triage_zammad_client.find_ticket_responsible_subject(ticket_id)
      responsible_subject = ResponsibleSubject.find(responsible_subject_hash[:value])

      return unless responsible_subject.pro?

      client = Client.find_by!(responsible_subject: responsible_subject)
      webhook_client.new(client).activity_created(ticket_id, article_id)
    end

    if article[:body].include? FRONTEND_MESSAGE_TAG
      # TODO send to frontend
    end
  end
end
