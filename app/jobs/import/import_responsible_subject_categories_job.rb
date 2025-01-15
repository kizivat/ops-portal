module Import
  class ImportResponsibleSubjectCategoriesJob < ApplicationJob
    def perform
      Legacy::ResponsibleSubjectCategory.find_in_batches do |group|
        group.each do |legacy_record|
          ResponsibleSubjectCategory.find_or_create_by!(
            id: legacy_record.id,
            responsible_subject: ResponsibleSubject.find_by_id(legacy_record.id_zodpovednost),
            issue_category_id: legacy_record.id_kategoria,
          )
        end
      end
    end
  end
end
