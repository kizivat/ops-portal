module Import
  class Issues::ImportIssueCommunicationsJob < ApplicationJob
    include ImportHelper

    def perform(issue:)
      Legacy::GenericModel.set_table_name("communication")
      Legacy::GenericModel.where(alert: issue.id).find_in_batches do |group|
        group.each do |legacy_record|
          issue.communications.find_or_create_by!(
            id: legacy_record.id,
            added_at: convert_timestamp_value(legacy_record.ts),
            confirmation_needed: legacy_record.need_confirmation,
            # email: legacy_record.email, TODO skip emails for now
            from_responsible_subject: legacy_record.direction,
            internal: legacy_record.internal,
            ip: legacy_record.ip,
            message: legacy_record.message,
            plain_message: legacy_record.plain_message,
            signature: legacy_record.signature,
            solution_rejected: legacy_record.solution_rejected,
            solved: legacy_record.solution_done,
            solved_by: legacy_record.solution_who,
            solved_in: legacy_record.solution_when,
            subject: legacy_record.subject,
            text: legacy_record.text,
            admin_id: legacy_record.admin,
            person_id: legacy_record.person,
            user_id: legacy_record.user
          )
        end
      end
    end
  end
end
