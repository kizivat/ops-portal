module Import
  class ImportResponsibleSubjectsDataJob < ApplicationJob
    def perform
      ResponsibleSubjects::ImportTypesJob.perform_later(chain_import: true)
    end
  end
end
