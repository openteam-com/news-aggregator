class AddCityToSource < ActiveRecord::Migration
  def change
    add_column :sources, :city_id, :integer
  end
end
