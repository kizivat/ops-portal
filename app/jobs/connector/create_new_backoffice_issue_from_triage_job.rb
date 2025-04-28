class Connector::CreateNewBackofficeIssueFromTriageJob < ApplicationJob
  def perform(tenant, issue_id, import: false, zammad_api_client: Connector::ZammadApiClient, ops_api_client: Connector::OpsApiClient)
    ops_client = ops_api_client.new(tenant)
    zammad_client = zammad_api_client.new(tenant)

    zammad_client.check_import_mode! if import

    issue_data = ops_client.get_issue(issue_id, include_customer_activities: tenant.receive_customer_activities?, exclude_responsible_subject_articles: import)
    zammad_client.create_issue!(issue_data)
  end
end
