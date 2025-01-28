class ImportJob < ApplicationJob
  def perform
    ImportAddressDataJob.perform_later
    Issues::ImportCategoriesJob.perform_later
    ImportResponsibleSubjectsDataJob.perform_later
    ImportMunicipalityUserRolesJob.perform_later
  end
end
