class AddSourceToRssbase < ActiveRecord::Migration
  def change
    add_column :rssbases, :source, :string
  end
end
