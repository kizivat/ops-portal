module Import
  class ImportUsersJob < ApplicationJob
    queue_with_priority 100

    def perform
      Legacy::OldUser.where(rights: "U").find_each do |legacy_record|
        user = Legacy::User.create_user_from_legacy_record(legacy_record)
        ImportUserAvatarJob.perform_later(user)
      end
    end
  end
end
