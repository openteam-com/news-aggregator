class CreateRssSettings < ActiveRecord::Migration
  def change
    create_table :rss_settings do |t|
      t.string :url
      t.string :source
      t.timestamps
    end
  end
end
