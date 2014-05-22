class RenameStatisticsColumnsInEntry < ActiveRecord::Migration
  def up
    rename_column :entries, :vk_stat, :vk_shares_count
    rename_column :entries, :vk_likes, :vk_likes_count
    rename_column :entries, :vk_comments, :vk_comments_count
    rename_column :entries, :facebook_stat, :facebook_shares_count
    rename_column :entries, :facebook_comments, :facebook_comments_count
    rename_column :entries, :twitter_stat, :twitter_shares_count
  end

  def down
    rename_column :entries, :vk_shares_count, :vk_stat
    rename_column :entries, :vk_likes_count, :vk_likes
    rename_column :entries, :vk_comments_count, :vk_comments
    rename_column :entries, :facebook_shares_count, :facebook_stat
    rename_column :entries, :facebook_comments_count, :facebook_comments
    rename_column :entries, :twitter_shares_count, :twitter_stat
  end
end
