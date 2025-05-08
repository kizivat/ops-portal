module Import
  class ImportAgentsJob < ApplicationJob
    queue_with_priority 100

    include ImportMethods

    def perform
      Legacy::OldUser.where(rights: %w[A Ax]).find_each do |legacy_record|
        Legacy::User.create_agent_from_legacy_record(legacy_record)
      end
    end
  end
end
