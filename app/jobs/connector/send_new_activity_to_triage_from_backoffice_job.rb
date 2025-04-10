class Connector::SendNewActivityToTriageFromBackofficeJob < ApplicationJob
  def perform(tenant, ticket_id, article_id, zammad_api_client: Connector::ZammadApiClient, ops_api_client: Connector::OpsApiClient)
    puts "------------------------------------------------- 0"
    puts "|#{tenant.activities.find_by(backoffice_external_id: article_id)&.triage_external_id}|"
    return if tenant.activities.find_by(backoffice_external_id: article_id)&.triage_external_id

    puts "------------------------------------------------- 1"
    activity = zammad_api_client.new(tenant).get_activity(ticket_id, article_id)
    puts "------------------------------------------------- 2"
    issue = tenant.issues.find_by!(backoffice_external_id: ticket_id)
    puts "------------------------------------------------- 3"
    activity_triage_external_id = ops_api_client.new(tenant).create_activity!(issue.triage_external_id, activity)
    puts "------------------------------------------------- 4"

    tenant.activities.create!(triage_external_id: activity_triage_external_id, backoffice_external_id: article_id)
    puts "------------------------------------------------- 5"
  end
end
