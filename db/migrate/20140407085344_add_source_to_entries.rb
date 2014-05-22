class AddSourceToEntries < ActiveRecord::Migration
  def up
    remove_column :entries, :source
    add_column :entries, :source_id, :integer
    add_index :entries, :source_id
  end

  def down
    remove_column :entries, :source_id
    add_column :entries, :source, :string
  end
end
