class Issues::SyncIssueUpdateToTriageJob < ApplicationJob
  queue_as :default

  def perform(update)
    # TODO triage process
    # set confirmed = true if successfully confirmed
    # set published = false if rejected
  end
end
