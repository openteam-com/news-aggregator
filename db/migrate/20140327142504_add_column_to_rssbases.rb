class AddColumnToRssbases < ActiveRecord::Migration
  def change
    add_column :rssbases, :status, :string
  end
end
