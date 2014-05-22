class AddColumnToRssSettings < ActiveRecord::Migration
  def change
    add_column :rss_settings, :title, :string
  end
end
