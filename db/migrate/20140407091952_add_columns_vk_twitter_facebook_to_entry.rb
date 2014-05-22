class AddColumnsVkTwitterFacebookToEntry < ActiveRecord::Migration
  def up
    add_column :entries, :vk_stat, :integer
    add_column :entries, :vk_likes, :integer
    add_column :entries, :vk_comments, :integer
    add_column :entries, :vk_updated_at, :datetime
    add_column :entries, :facebook_stat, :integer
    add_column :entries, :facebook_comments, :integer
    add_column :entries, :facebook_updated_at, :datetime
    add_column :entries, :twitter_stat, :integer
    add_column :entries, :twitter_updated_at, :datetime
  end

  def down
    remove_columns :entries, :vk_stat, :vk_likes, :vk_comments, :vk_updated_at, :facebook_stat, :facebook_comments, :facebook_updated_at, :twitter_stat, :twitter_updated_at
  end
end
