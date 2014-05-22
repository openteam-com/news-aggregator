class AddColumnRatingToRssbase < ActiveRecord::Migration
  def change
    add_column :rssbases, :rating, :float, default: 0
  end
end
