class RemoveColumnsFromRssbase < ActiveRecord::Migration
  def change
    remove_columns :rssbases, :content, :theme, :status, :image_url, :main, :category
  end
end
