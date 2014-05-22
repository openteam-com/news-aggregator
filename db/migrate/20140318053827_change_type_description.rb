class ChangeTypeDescription < ActiveRecord::Migration
  def up
    change_column :rssbases, :description, :text
  end

  def down
    change_column :rssbases, :description, :string
  end
end
