class RenamePostToEntry < ActiveRecord::Migration
  def up
    rename_table :posts, :entries
  end

  def down
    rename_table :entries, :posts
  end
end
