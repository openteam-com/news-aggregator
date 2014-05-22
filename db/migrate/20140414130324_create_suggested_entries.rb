class CreateSuggestedEntries < ActiveRecord::Migration
  def up
    create_table :suggested_entries do |t|
      t.string :url
      t.text :title
      t.string :entry_type
      t.timestamps
    end
  end

  def down
    drop_table :suggested_entries
  end
end
