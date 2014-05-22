class RenamePublishedToPublishedAt < ActiveRecord::Migration
  def up
    rename_column :entries, :published, :published_at
  end

  def down
    rename_column :entries, :published_at, :published
  end
end
