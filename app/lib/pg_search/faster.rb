module PgSearch
  module Faster
    extend ActiveSupport::Concern

    class_methods do
      def fulltext_search(query, against:, unaccent_f: "unaccent")
        query_sql = query.split.compact.map do
          "to_tsquery('simple', ''' ' || #{unaccent_f}(?) || ' ''')"
        end.join(" && ")

        where("#{fulltext_index_expression(against:, unaccent_f:)} @@ (#{query_sql})", *query.split.compact)
      end

      def fulltext_index_expression(against:, unaccent_f: "unaccent")
        expr = against.map do |column|
          "to_tsvector('simple', #{unaccent_f}(coalesce((#{table_name}.#{column})::text, '')))"
        end.join(" || ")

        "(#{expr})"
      end
    end
  end
end
