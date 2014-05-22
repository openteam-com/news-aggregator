class DropStatisticTable < ActiveRecord::Migration
  def up
    drop_table :statistics
  end

  def down
    create_table :statistics do |t|
      t.integer :rssbase_id
      t.integer :twitter_stat, default: 0
      t.integer :vk_stat, default: 0
      t.integer :vk_likes, default: 0
      t.integer :vk_comments, default: 0
      t.integer :facebook_stat, default: 0
      t.integer :facebook_comments, default: 0
      t.timestamps
    end
  end
end
