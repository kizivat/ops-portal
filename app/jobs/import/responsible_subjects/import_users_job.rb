module Import
  class ResponsibleSubjects::ImportUsersJob < ApplicationJob
    queue_with_priority 100

    include ImportMethods

    def perform
      Legacy::MunicipalityUser.find_in_batches do |group|
        group.each do |legacy_record|
          Legacy::User.create_responsible_subjects_user_from_legacy_record(legacy_record)
        end
      end
    end
  end
end
