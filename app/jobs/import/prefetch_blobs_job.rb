module Import
  class PrefetchBlobsJob < ApplicationJob
    queue_with_priority 100

    def perform
      Municipality.find_each do |municipality|
        Blobs::PrefetchMunicipalityAlertsBlobsJob.perform_later(municipality: municipality)
      end
    end
  end
end
