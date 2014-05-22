class RenameEntriesToPosts < ActiveRecord::Migration
  def up
    rename_table :entries, :posts
  end

  def down
    rename_table :posts, :entries
  end
end
