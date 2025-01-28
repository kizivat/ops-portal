module Import
  class ImportAddressDataJob < ApplicationJob
    def perform
      Addresses::ImportDistrictsJob.perform_later(chain_import: true)
    end
  end
end
