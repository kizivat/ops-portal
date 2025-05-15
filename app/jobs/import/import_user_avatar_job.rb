module Import
  class ImportUserAvatarJob < ApplicationJob
    queue_with_priority 100

    include ImportMethods

    def perform(user)
      user.avatar.attach(io: download_avatar_from_ops_portal(user.legacy_id), filename: "#{user.id}.jpg") unless user.avatar.attached?
    end
  end
end
