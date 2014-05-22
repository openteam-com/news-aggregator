class AddColumn < ActiveRecord::Migration
  def change
    add_column :rssbases, :news_type, :string
  end
end
