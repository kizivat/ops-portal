class IndexFulltext < ActiveRecord::Migration[8.0]
  def up
    # make unaccent immutable to allow indexing
    execute <<-SQL
      CREATE OR REPLACE FUNCTION f_unaccent(text) RETURNS text
      AS $$
        SELECT public.unaccent('public.unaccent', $1);
      $$ LANGUAGE sql IMMUTABLE PARALLEL SAFE STRICT;
    SQL

    expr = <<-SQL
      (to_tsvector('simple', f_unaccent(coalesce(("issues"."title")::text, ''))) || to_tsvector('simple', f_unaccent(coalesce(("issues"."description")::text, ''))) || to_tsvector('simple', f_unaccent(coalesce(("issues"."legacy_id")::text, ''))) || to_tsvector('simple', f_unaccent(coalesce(("issues"."id")::text, ''))))
    SQL

    add_index :issues, expr, using: :gin, name: :issues_fulltext_idx
  end

  def down
    remove_index :issues, name: :issues_fulltext_idx

    execute <<-SQL
      DROP FUNCTION f_unaccent(text);
    SQL
  end
end
