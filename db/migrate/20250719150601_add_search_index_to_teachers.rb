class AddSearchIndexToTeachers < ActiveRecord::Migration[8.0]
  def up
    execute "CREATE INDEX index_teachers_on_full_name ON teachers USING gin(to_tsvector('russian', surname || ' ' || name || ' ' || patronymic))"
  end

  def down
    execute "DROP INDEX index_teachers_on_full_name"
  end
end