class RenameRssSettingsToSource < ActiveRecord::Migration
  def up
    rename_table :rss_settings, :sources
  end

  def down
    rename_table :sources, :rss_settings
  end
end
