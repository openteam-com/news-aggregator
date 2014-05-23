class AddFacebookLikesCountToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :facebook_likes_count, :integer
  end
end
