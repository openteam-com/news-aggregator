class AddCityToSource < ActiveRecord::Migration
  def change
    add_column :sources, :city, :string

    Source.update_all :city => 'tomsk'

    Entry.reindex
  end
end
