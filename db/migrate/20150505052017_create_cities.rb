class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :title
      t.string :slug

      t.string :meta_title
      t.string :meta_keywords
      t.string :meta_description

      t.timestamps
    end
  end
end
