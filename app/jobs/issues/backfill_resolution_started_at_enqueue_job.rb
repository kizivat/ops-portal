class Issues::BackfillResolutionStartedAtEnqueueJob < ApplicationJob
  queue_as :default

  DEFAULT_BATCH_SIZE = 500

  def perform(batch_size: DEFAULT_BATCH_SIZE)
    scope = Issue.pending_resolution_started_at_backfill.select(:id)
    return unless scope.exists?

    scope.in_batches(of: batch_size) do |relation|
      Issues::BackfillResolutionStartedAtBatchJob.perform_later(issue_ids: relation.ids)
    end
  end
end
