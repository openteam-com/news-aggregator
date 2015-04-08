class AddCityToSource < ActiveRecord::Migration
  def change
    add_column :sources, :city, :string

    Source.all.each do |source|
      source.update_attribute(:city, 'Томск')
    end
  end
end
