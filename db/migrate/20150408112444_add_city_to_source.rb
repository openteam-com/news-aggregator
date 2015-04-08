class AddCityToSource < ActiveRecord::Migration
  def change
    add_column :sources, :city, :string
  end
end
