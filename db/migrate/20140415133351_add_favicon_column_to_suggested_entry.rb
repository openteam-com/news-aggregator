class AddFaviconColumnToSuggestedEntry < ActiveRecord::Migration
  def up
    add_column :suggested_entries, :favicon, :string
    SuggestedEntry.all.map{|entry| entry.set_favicon}
  end

  def down
    remove_column :suggested_entries, :favicon
  end
end
