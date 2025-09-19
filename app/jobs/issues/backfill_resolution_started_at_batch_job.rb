class Issues::BackfillResolutionStartedAtBatchJob < ApplicationJob
  queue_as :default

  def perform(issue_ids:)
    return if issue_ids.blank?

    client = TriageZammadEnvironment.client

    updates = []

    Issue.where(id: issue_ids).select(:id, :resolution_external_id).find_each do |issue|
      ticket = client.get_ticket(issue.resolution_external_id)
      raise "ticket not found for issue #{issue.id} external_id=#{issue.resolution_external_id}" if ticket.nil?

      raw_created_at = ticket[:created_at]
      raise "ticket missing created_at for issue #{issue.id} external_id=#{issue.resolution_external_id}" if raw_created_at.blank?

      parsed_time = raw_created_at.is_a?(Time) ? raw_created_at : Time.iso8601(raw_created_at.to_s)
      updates << { id: issue.id, resolution_started_at: parsed_time }
    end

    Issue.upsert_all(updates, unique_by: :id) if updates.any?
  end
end
