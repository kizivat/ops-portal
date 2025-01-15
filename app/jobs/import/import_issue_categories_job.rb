module Import
  class ImportIssueCategoriesJob < ApplicationJob
    def perform
      Legacy::Issue::Category.find_in_batches do |group|
        group.each do |legacy_record|
          find_or_create_category_with_parent(legacy_record)
        end
      end
    end

    private

    def find_or_create_category_with_parent(legacy_record)
      legacy_parent_record = if legacy_record.parent.present?
        load_parent_record_data(legacy_record.parent)
      end

      find_or_create_category(legacy_record, legacy_parent_record)
    end

    def load_parent_record_data(record_id)
      return Issue::Category.find_by_id(record_id) if Issue::Category.find_by_id(record_id)

      record = Legacy::Issue::Category.find_by_id(record_id)

      find_or_create_category_with_parent(record) if record
    end

    def find_or_create_category(legacy_record, legacy_parent_record)
      ::Issue::Category.find_or_create_by!(
        id: legacy_record.id,
        catch_all: legacy_record.catch_all,
        category: legacy_record.kategoria,
        category_hu: legacy_record.kategoria_hu,
        category_alias: legacy_record.kategoria_alias,
        description: legacy_record.popis.presence,
        description_hu: legacy_record.popis_hu.presence,
        weight: legacy_record.weight,
        parent: legacy_parent_record
      )
    end
  end
end
