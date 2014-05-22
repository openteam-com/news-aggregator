class RenameRssbaseToEntry < ActiveRecord::Migration
  def up
    rename_table :rssbases, :entries
  end

  def down
    rename_table :entries, :rssbases
  end
end
